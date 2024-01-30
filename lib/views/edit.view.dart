import 'package:flutter/material.dart';
import 'package:seniors_connect/models/organisation.model.dart';
import 'package:seniors_connect/utils/firebase.services.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/views/widget/button.form.dart';
import 'package:seniors_connect/views/widget/text.area.dart';
import 'package:seniors_connect/views/widget/text.box.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditView extends StatefulWidget {

  EditView({super.key, required this.organisation});

  final Organisation organisation;

  @override
  State<EditView> createState() => _EditViewState(organisation);
}

class _EditViewState extends State<EditView> {

  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController websiteController = TextEditingController();

  final TextEditingController serviceController = TextEditingController();

  _EditViewState(Organisation organisation){
      oldOrganisation = organisation;
      nameController.text = organisation.name;
      addressController.text = organisation.address;
      emailController.text = organisation.email;
      phoneController.text = organisation.phone;
      websiteController.text = organisation.website;
      serviceController.text = organisation.services;
      selectedValue = organisation.status!;
  }
  late Organisation oldOrganisation;
  String selectedValue = "";

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: GlobalColors.backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: GlobalColors.textColor,
                      size: 25,
                    )
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Edit Organisation",
                        style: TextStyle(
                            fontFamily: "bold",
                            color: GlobalColors.textColor,
                            fontSize: 25
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 25,)
                ],
              ),
              SizedBox(height: 40,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextBox(controller: nameController, text: "Name", obscure: false, textInputType: TextInputType.name, icon: Icons.apartment),
                      SizedBox(height: 10,),
                      TextBox(controller: addressController, text: "Address", obscure: false, textInputType: TextInputType.streetAddress,icon: Icons.location_on_outlined,),
                      SizedBox(height: 10,),
                      TextBox(controller: emailController, text: "Email", obscure: false, textInputType: TextInputType.emailAddress,icon: Icons.email_outlined,),
                      SizedBox(height: 10,),
                      TextBox(controller: phoneController, text: "Phone number", obscure: false, textInputType: TextInputType.phone,icon: Icons.phone_outlined),
                      SizedBox(height: 10,),
                      TextBox(controller: websiteController, text: "Website", obscure: false, textInputType: TextInputType.text,icon: Icons.web_outlined),
                      SizedBox(height: 10,),
                      TextArea(controller: serviceController, text: "Services", obscure: false, textInputType: TextInputType.text,icon: Icons.description_outlined),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow:[ BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 7
                          )]
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                        child: Row(
                          children: [
                            Text(
                              "Status: ",
                              style: TextStyle(
                                fontFamily: "medium",
                                color: Colors.black,
                                fontSize: 17
                              ),
                            ),
                            SizedBox(width: 10,),
                            DropdownButton<String>(
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                });
                              },
                              items: <String>['Rejected', 'Approved', 'Pending']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontFamily: "regular",
                                      color: GlobalColors.textColor
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      _loading? SpinKitCircle(
                        color: GlobalColors.mainColor,
                        size: 50.0,
                      ):TextButton(
                        onPressed: (){
                          _startLoading();
                          updateOrganisation();
                        },
                        child: ButtonForm(text: "Update")
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void updateOrganisation() async {
    String name = nameController.text.trim();
    String address = addressController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String website = websiteController.text.trim();
    String services = serviceController.text.trim();

    if (name.isEmpty || address.isEmpty || email.isEmpty || phone.isEmpty || website.isEmpty || services.isEmpty) {
      Fluttertoast.showToast(
        msg: "All the fields are required",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _stopLoading();
    }else{
      Organisation newOrganisation = Organisation(
        id: oldOrganisation.id,
        name: name,
        address: address,
        email: email,
        phone: phone,
        website: website,
        services: services,
        status: selectedValue,
        isAdmin: oldOrganisation.isAdmin
      );
      await FirebaseServices.updateOrganisation(newOrganisation);
      _stopLoading();
    }
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
