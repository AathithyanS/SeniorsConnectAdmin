import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/firebase.services.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:get/get.dart';
import 'package:seniors_connect/views/login.view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;
  String email = "Null";
  ProfilePage({super.key}){


    if (user != null) {
      String? emailU = user!.email; // Use ?? to provide a default value if email is null
      if(emailU != null){
        email  = emailU;
      }else{
        print("not found");
      }
      print("Email of logged-in user: $emailU");
    } else {
      print("User is not logged in.");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: GlobalColors.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Profile",
                  style: TextStyle(
                    fontFamily: "bold",
                    fontSize: 34,
                    color: GlobalColors.textColor
                  ),
                ),
                InkWell(
                  onTap: ()async{
                    await FirebaseServices.signOutFirebase();
                    Get.offAll(LoginView());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: GlobalColors.logoutBackColor,
                      borderRadius: BorderRadius.circular(7)
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: "bold",
                        fontSize: 12,
                        color: GlobalColors.logoutColor
                      ),
                    ),
                  ),
                )
              ],
              ),
              SizedBox(height: 60,),
              Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: GlobalColors.mainColor,
                  borderRadius: BorderRadius.circular(100)
                ),
                child: Icon(Icons.person, size: 70, color: Colors.white,),
              ),
              SizedBox(height: 20,),
              Text(
                "Admin",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: "bold",
                  color: GlobalColors.textColor
                ),
              ),
              SizedBox(height: 10,),
              Text(
                email,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: "regular",
                  color: GlobalColors.textColor
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1. If you want extra admin function you can login in to the Firebase account with give Gmail id and password and get all the access of the Application."
                      ),
                      SizedBox(height: 10,),
                      Text(
                          "2. Using Firebase Authentication Feature you can add new admins and delete already exist admins."
                      ),
                      SizedBox(height: 10,),
                      Text(
                          "3. Using Firebase Realtime database your can manually handle the physical databases."
                      ),
                      SizedBox(height: 10,),
                      Text(
                          "4. If you want developer contact:\n    \u2605 I'm Aathithyan\n    \u2605 Email: sriramachchanthiranaathithyan@gmail.com\n    \u2605 Whatsapp: +94771715935"
                      ),
                    ],
                  ),
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}
