import 'package:flutter/material.dart';
import 'package:seniors_connect/models/organisation.model.dart';
import 'package:seniors_connect/utils/firebase.services.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/views/widget/button.form.dart';
import 'package:seniors_connect/views/widget/text.area.dart';
import 'package:seniors_connect/views/widget/text.box.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddPage extends StatefulWidget {
  AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  bool _loading = false;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController websiteController = TextEditingController();

  final TextEditingController serviceController = TextEditingController();

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
              Text(
                "Add Organisation",
                style: TextStyle(
                  fontFamily: "bold",
                  color: GlobalColors.textColor,
                  fontSize: 25
                ),
              ),
              SizedBox(height: 40,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextBox(controller: nameController, text: "Name", obscure: false, textInputType: TextInputType.name, icon: Icons.apartment_outlined),
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
                      SizedBox(height: 20,),
                      _loading? SpinKitCircle(
                        color: GlobalColors.mainColor,
                        size: 50.0,
                      ):InkWell(
                        onTap: (){
                          _startLoading();
                          addOrganisation();
                        },
                        child: ButtonForm(text: "Add")
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

  void addOrganisation() async {
    String name = nameController.text.trim();
    String address = addressController.text.trim().isEmpty?"Not available":addressController.text.trim();
    String email = emailController.text.trim().isEmpty?"Not available":emailController.text.trim();
    String phone = phoneController.text.trim().isEmpty?"Not available":phoneController.text.trim();
    String website = websiteController.text.trim().isEmpty?"Not available":websiteController.text.trim();
    String services = serviceController.text.trim().isEmpty?"Not available":serviceController.text.trim();

    if (name.isEmpty) {
      Fluttertoast.showToast(
        msg: "Name field is required",
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
        name: name,
        address: address,
        email: email,
        phone: phone,
        website: website,
        services: services,
        status: "Approved",
        isAdmin: true
      );
      bool result = await FirebaseServices.saveOrganisation(newOrganisation);
      if(result){
        nameController.text = "";
        addressController.text = "";
        emailController.text = "";
        phoneController.text = "";
        websiteController.text = "";
        serviceController.text = "";
      }
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
