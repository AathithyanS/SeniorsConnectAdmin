import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/firebase.services.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/views/home.view.dart';
import 'package:seniors_connect/views/widget/button.form.dart';
import 'package:seniors_connect/views/widget/text.box.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();

}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.backgroundColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(left: 17, right: 17),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30,),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: GlobalColors.textColor,
                          fontSize: 34,
                          fontFamily: 'Bold',
                        ),
                      ),
                      SizedBox(height: 100,),
                      TextBox(controller: emailController, text: "Email", obscure: false, textInputType: TextInputType.emailAddress,icon: Icons.email_outlined),
                      SizedBox(height: 15,),
                      TextBox(controller: passwordController, text: "Password", obscure: true, textInputType: TextInputType.text,icon: Icons.lock_outline),
                      SizedBox(height: 20,),
                      // Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       InkWell(
                      //         onTap:(){
                      //           Get.to(ForgotView());
                      //         },
                      //         child: Text(
                      //           'Forgot your password? ',
                      //           style: TextStyle(
                      //               color: GlobalColors.textColor,
                      //               fontFamily: 'Medium',
                      //               fontSize: 14
                      //           ),
                      //         ),
                      //       ),
                      //       Icon(
                      //         Icons.arrow_right_alt,
                      //         color: GlobalColors.mainColor,
                      //         size: 30,
                      //       )
                      //     ]
                      // ),
                      SizedBox(height: 40,),
                      _loading? SpinKitCircle(
                        color: GlobalColors.mainColor,
                        size: 50.0,
                      ):
                      InkWell(
                          onTap: () async{
                            _startLoading();
                            User? user = await FirebaseServices.signInWithFirebase(emailController.text, passwordController.text);
                            if(user != null){
                              Get.off(HomeView());
                            }else{
                              _stopLoading();
                            }
                            // Perform your asynchronous task here
                            // Future.delayed(Duration(seconds: 2), () {
                            //   _stopLoading();
                            //   Get.off(HomeView());
                            // });
                          },
                          child: ButtonForm(text: "LOGIN",)
                      ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }

  void _startLoading() {
    setState(() {
      _loading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      _loading = false;
    });
  }

}
