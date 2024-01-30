import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/views/login.view.dart';
import 'package:seniors_connect/views/widget/button.form.dart';
import 'package:seniors_connect/views/widget/text.box.dart';
import 'package:get/get.dart';


class UpdatePasswordView extends StatelessWidget {
  UpdatePasswordView({super.key});

  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

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
                'Update password',
                style: TextStyle(
                  color: GlobalColors.textColor,
                  fontSize: 34,
                  fontFamily: 'Bold',
                ),
              ),
              SizedBox(height: 80,),
              const Text(
                "Please enter your new password.",
                style: TextStyle(
                    fontFamily: "Medium",
                    fontSize: 14
                ),
              ),
              SizedBox(height: 20,),
              TextBox(controller: passController, text: "New password", textInputType: TextInputType.emailAddress, obscure: false,icon: Icons.lock_outline),
              SizedBox(height: 15,),
              TextBox(controller: confirmPassController, text: "Confirm password", textInputType: TextInputType.emailAddress, obscure: false, icon: Icons.lock_outline),
              SizedBox(height: 30,),
              InkWell(
                  onTap: () {
                    Get.offAll(() => LoginView());
                  },
                  child: ButtonForm(text: "Submit")
              )
            ],
          ),
        ),
      ),
    );
  }
}
