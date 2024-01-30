import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:seniors_connect/models/organisation.model.dart';
import 'package:get/get.dart';
import 'package:seniors_connect/views/home.view.dart';

class FirebaseServices{

  static CollectionReference organisationsCollection = FirebaseFirestore.instance.collection('organisations');

  static Future<User?> signInWithFirebase(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = FirebaseAuth.instance.currentUser;
      return user;
    } catch (e) {
      String errorMessage = "Login failed";

      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          errorMessage = "Email or password is incorrect";
        } else if (e.code == 'network-request-failed') {
          errorMessage = "Internet is not available";
        }
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return null;
    }
  }

  static Future<bool> isUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  static Future<void> signOutFirebase() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<bool> addOrganisationToFirebase(Organisation organisation) async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
      DatabaseReference organisationsReference = databaseReference.child('organisations');

      // Use push to generate a new unique key
      DatabaseReference newOrganisationReference = organisationsReference.push();

      // Set the values for the new organisation
      await newOrganisationReference.set({
        'name': organisation.name,
        'address': organisation.address,
        'email': organisation.email,
        'phone': organisation.phone,
        'website': organisation.website,
        'services': organisation.services,
        'status': organisation.status,
      });

      Fluttertoast.showToast(
        msg: "Organisation added successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Error adding organisation: $error",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("Error adding organisation: $error");
      // Handle the error as needed
      return false;
    }
  }

  static Future<List<Organisation>> getOrganisations() async {
    final databaseReference = FirebaseDatabase.instance.reference();
    final organisationsSnapshot = await databaseReference.child('organisations').once();

    final organisations = <Organisation>[];
    if (organisationsSnapshot.snapshot.value != null) {
      final organisationData = LinkedHashMap<String, dynamic>.from(
        (organisationsSnapshot.snapshot.value as Map<dynamic, dynamic>),
      );

      // Iterate through keys in reverse order to get added order
      for (final org in organisationData.values) {
        // final organisationValues = organisationData[key];
        final organisation = Organisation(
          id: org[""],
          name: org['name'],
          address: org['address'],
          email: org['email'],
          phone: org['phone'],
          website: org['website'],
          services: org['services'],
          status: org['status'],
          isAdmin: org['isAdmin'],
        );
        organisations.add(organisation);
      }
    }

    return organisations;
  }


  static Future<bool> saveOrganisation(Organisation organisation) async {
    try {
      await organisationsCollection.add({
        'isAdmin': true,
        'dateTime': FieldValue.serverTimestamp(),
        'name': organisation.name,
        'address': organisation.address,
        'email': organisation.email,
        'phone': organisation.phone,
        'website': organisation.website,
        'services': organisation.services,
        'status': "Approved",
      });
      Fluttertoast.showToast(
        msg: "Organisation successfully added!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error adding organisation: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('Error saving organisation: $e');
      // Handle the error as needed
      return false;
    }
  }

  static Future<List<Organisation>> getFirestoreOrganisations() async {
    try {
      QuerySnapshot querySnapshot =
      await organisationsCollection.orderBy('dateTime', descending: true).get();

      List<Organisation> organisationsList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Organisation(
          id: doc.id,
          isAdmin: data['isAdmin'],
          dateTime: data['dateTime'],
          name: data['name'],
          address: data['address'],
          email: data['email'],
          phone: data['phone'],
          website: data['website'],
          services: data['services'],
          status: data['status'],
        );
      }).toList();

      return organisationsList;
    } catch (e) {
      print('Error retrieving organisations: $e');
      Fluttertoast.showToast(
        msg: "Error for getting organisations: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Handle the error as needed
      return [];
    }
  }

  static Future<void> deleteOrganisationById(String organisationId) async {
    try {
      await organisationsCollection.doc(organisationId).delete();
      Fluttertoast.showToast(
        msg: "Organisation deleted successfully.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Deletion of organisation is not successful: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Handle the error as needed
    }
  }

  static Future<void> updateOrganisation(Organisation updatedOrganisation) async {
    try {
      await organisationsCollection.doc(updatedOrganisation.id!).update({
        'isAdmin': updatedOrganisation.isAdmin,
        'name': updatedOrganisation.name,
        'address': updatedOrganisation.address,
        'email': updatedOrganisation.email,
        'phone': updatedOrganisation.phone,
        'website': updatedOrganisation.website,
        'services': updatedOrganisation.services,
        'status': updatedOrganisation.status,
        // Add other fields as needed
      });
      Fluttertoast.showToast(
        msg: "Update organisation successfully completed.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Get.offAll(HomeView());
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Update organisation is not successful: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('Error updating organisation: $e');
    }
  }


  static Future<List<Organisation>> searchOrganisationsByName(String searchText) async {
    try {
      String lowerSearchText = searchText.toLowerCase();

      QuerySnapshot querySnapshot = await organisationsCollection
          .orderBy('name')
          .startAt([lowerSearchText])
          .endAt([lowerSearchText + '\uf8ff'])
          .get();

      List<Organisation> organisationsList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Organisation(
          id: doc.id,
          isAdmin: data['isAdmin'],
          name: data['name'],
          address: data['address'],
          email: data['email'],
          phone: data['phone'],
          website: data['website'],
          services: data['services'],
          status: data['status'],
          dateTime: data['dateTime'],
        );
      }).toList();

      return organisationsList;
    } catch (e) {
      print('Error searching organisations by name: $e');
      // Handle the error as needed
      Fluttertoast.showToast(
        msg: "Search organisations not successful: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return [];
    }
  }

  static Future<List<Organisation>> getAdminOrganisations() async {
    try {
      QuerySnapshot querySnapshot =
      await organisationsCollection.where('isAdmin', isEqualTo: true).get();

      List<Organisation> organisationsList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Organisation(
          id: doc.id,
          isAdmin: data['isAdmin'],
          name: data['name'],
          address: data['address'],
          email: data['email'],
          phone: data['phone'],
          website: data['website'],
          services: data['services'],
          status: data['status'],
          dateTime: data['dateTime'],
        );
      }).toList();

      return organisationsList;
    } catch (e) {
      print('Error getting admin organisations: $e');
      Fluttertoast.showToast(
        msg: "Get admin organisation is not successful: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Handle the error as needed
      return [];
    }
  }

  static Future<List<Organisation>> getFilterOrganisations(String status) async {
    try {
      QuerySnapshot querySnapshot =
      await organisationsCollection.where('status', isEqualTo: status).get();

      List<Organisation> organisationsList = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Organisation(
          id: doc.id,
          isAdmin: data['isAdmin'],
          name: data['name'],
          address: data['address'],
          email: data['email'],
          phone: data['phone'],
          website: data['website'],
          services: data['services'],
          status: data['status'],
          dateTime: data['dateTime'],
        );
      }).toList();

      return organisationsList;
    } catch (e) {
      print('Error getting approved organisations: $e');
      Fluttertoast.showToast(
        msg: "Filter organisation is not successful: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      // Handle the error as needed
      return [];
    }
  }

  static Future<bool> saveOrganisations(List<Organisation> organisations) async {
    try {
      CollectionReference organisationsCollection =
      FirebaseFirestore.instance.collection('organisations');

      for (var organisation in organisations) {
        await organisationsCollection.add({
          'isAdmin': true,
          'dateTime': FieldValue.serverTimestamp(),
          'name': organisation.name,
          'address': organisation.address,
          'email': organisation.email,
          'phone': organisation.phone,
          'website': organisation.website,
          'services': organisation.services,
          'status': "Approved",
        });
      }

      print("Organisations successfully added!");
      return true;
    } catch (e) {
      print('Error saving organisations: $e');
      // Handle the error as needed
      return false;
    }
  }


}