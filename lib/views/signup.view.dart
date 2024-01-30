import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/views/verifyemail.view.dart';
import 'package:seniors_connect/views/widget/button.form.dart';
import 'package:seniors_connect/views/widget/text.box.dart';
import 'package:get/get.dart';


class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 17, right: 17),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        InkWell(
                          onTap: (){
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'Sign up',
                          style: TextStyle(
                            color: GlobalColors.textColor,
                            fontSize: 34,
                            fontFamily: 'Bold',
                          ),
                        ),
                        SizedBox(height: 80,),
                        TextBox(controller: nameController, text: "Name", obscure: false, textInputType: TextInputType.name,icon: Icons.person_outline),
                        SizedBox(height: 15,),
                        TextBox(controller: emailController, text: "Email", obscure: false, textInputType: TextInputType.emailAddress,icon: Icons.email_outlined),
                        SizedBox(height: 15,),
                        TextBox(controller: passwordController, text: "Password", obscure: true, textInputType: TextInputType.text,icon: Icons.lock_outline),
                        SizedBox(height: 40,),
                        InkWell(
                            onTap: (){
                              Get.to(VerifyEmailView());
                            },
                            child: ButtonForm(text: "Sign up",)
                        ),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "If you already have an account? ",
                        style: TextStyle(
                            fontFamily: "Regular",
                            fontSize: 14,
                            color: GlobalColors.textColor
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Bold",
                              color: Colors.black
                          ),
                        ),
                      ),
                      SizedBox(height: 40,)
                    ],
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}