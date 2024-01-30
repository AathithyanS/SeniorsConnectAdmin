import 'package:cloud_firestore/cloud_firestore.dart';

class Organisation {
  Organisation({
    this.id,
    this.isAdmin,
    this.dateTime,
    required this.name,
    required this.address,
    required this.email,
    required this.phone,
    required this.website,
    required this.services,
    this.status,
  });

  final String? id; // Use String? for nullable String
  final String name;
  final String address;
  final String email;
  final String phone;
  final String website;
  final String services;
  final String? status;
  final bool? isAdmin;
  final Timestamp? dateTime;
}
