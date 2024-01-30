import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/views/updatepassword.view.dart';
import 'package:seniors_connect/views/widget/button.form.dart';
import 'package:get/get.dart';
import 'package:otpview_sk/otpview_sk.dart';

class ForgotOtpView extends StatelessWidget {
  const ForgotOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 30,
                ),
              ),
              SizedBox(height: 20,),
              Text(
                'Confirm OTP',
                style: TextStyle(
                  color: GlobalColors.textColor,
                  fontSize: 34,
                  fontFamily: 'Bold',
                ),
              ),
              SizedBox(height: 80,),
              const Text(
                "Please, enter the OTP that you received on your email address.",
                style: TextStyle(
                    fontFamily: "Medium",
                    fontSize: 14
                ),
              ),
              SizedBox(height: 30,),
              OtpViews(
                obSecure: false,
                boxType: BoxType.rounded,
                keyboardType:TextInputType.number,
                textColor: GlobalColors.textColor,
                length: 4,
                onComplete: (otp){
                  print(otp);
                },
              ),
              SizedBox(height: 30,),
              InkWell(
                  onTap: () {
                    Get.to(UpdatePasswordView());
                  },
                  child: ButtonForm(text: "CONFIRM")
              )
            ],
          ),
        ),
      ),
    );
  }
}
