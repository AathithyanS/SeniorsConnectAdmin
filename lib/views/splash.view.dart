import 'dart:async';

import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/firebase.services.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:get/get.dart';
import 'package:seniors_connect/views/home.view.dart';
import 'package:seniors_connect/views/login.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3),() async{
      bool isLogin = await FirebaseServices.isUserLoggedIn();
      if(isLogin){
        Get.off(HomeView());
      }else{
        Get.off(LoginView());
      }

    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: Container(
        alignment: Alignment.center,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Text(
              "Seniors Connect\nAdmin",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "bold",
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            Text(
              "Artists and Artisans Development Network",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "light",
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ]
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(bottom: 15),
        child: Image.asset(
          "assets/images/brand_logo_white.png",
          width: 153,
          height: 62,
        )
      ),
    );
  }
}
