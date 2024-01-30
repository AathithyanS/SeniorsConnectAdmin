import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/views/forgot.otp.view.dart';
import 'package:seniors_connect/views/widget/button.form.dart';
import 'package:seniors_connect/views/widget/text.box.dart';
import 'package:get/get.dart';


class ForgotView extends StatelessWidget {
  ForgotView({super.key});

  final TextEditingController emailController = TextEditingController();

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
                'Forgot password',
                style: TextStyle(
                  color: GlobalColors.textColor,
                  fontSize: 34,
                  fontFamily: 'Bold',
                ),
              ),
              SizedBox(height: 80,),
              const Text(
                "Please, enter your email address. You will receive a link to create a new password via email.",
                style: TextStyle(
                  fontFamily: "Medium",
                  fontSize: 14
                ),
              ),
              SizedBox(height: 20,),
              TextBox(controller: emailController, text: "Email", textInputType: TextInputType.emailAddress, obscure: false, icon: Icons.email,),
              SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  Get.to(ForgotOtpView());
                },
                  child: ButtonForm(text: "SEND")
              )
            ],
          ),
        ),
      ),
    );
  }
}
