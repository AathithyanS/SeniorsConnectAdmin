import 'package:flutter/material.dart';
import 'package:seniors_connect/models/organisation.model.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:seniors_connect/utils/map.function.dart';
import 'package:seniors_connect/views/edit.view.dart';
import 'package:seniors_connect/views/widget/delete.dialog.dart';
import 'package:seniors_connect/views/widget/organisation.details.item.dart';
import 'package:seniors_connect/views/widget/service.dialog.dart';
import 'package:get/get.dart';

class OrganisationItem extends StatelessWidget {
  var statusColor = GlobalColors.pendingColor;
  var statusBackColor = GlobalColors.pendingBackColor;

  OrganisationItem({super.key, required this.organisation,  required this.onItemTap}){
    if(organisation.status == "Approved"){
      statusColor = GlobalColors.approveColor;
      statusBackColor = GlobalColors.approveBackColor;
    }else if(organisation.status == "Rejected"){
      statusColor = GlobalColors.rejectColor;
      statusBackColor = GlobalColors.rejectBackColor;
    }
  }

  final Organisation organisation;
  final VoidCallback onItemTap;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius:5
              )
            ]
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      organisation.name,
                      style: TextStyle(
                        fontFamily: "bold",
                        color: GlobalColors.mainColor,
                        fontSize: 12
                      ),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: statusBackColor,
                        ),
                        child: Text(
                          organisation.status!,
                          style: TextStyle(
                            color: statusColor,
                            fontFamily: "medium",
                            fontSize: 9
                          ),
                        ),
                      ),
                      SizedBox(width:7,),
                      InkWell(
                        onTap: (){
                          Get.to(EditView(organisation: organisation,));
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10
                              )
                            ]
                          ),
                          child: Icon(
                            Icons.edit,
                            color: GlobalColors.editColor,
                          ),
                        ),
                      ),
                      SizedBox(width: 7,),
                      InkWell(
                        onTap: (){
                          _showDelete(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10
                              )
                            ]
                          ),
                          child: Icon(
                            Icons.delete_outline,
                            color: GlobalColors.rejectColor,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 3,),
              Container(
                padding:const EdgeInsets.symmetric(horizontal: 10,),
                child: Column(
                  children: [
                    // OrganisationDetailsItem(icon: Icons.person_outline, text: "John Wick"),
                    // SizedBox(height: 3,),
                    OrganisationDetailsItem(icon: Icons.location_on_outlined, text: organisation.address),
                    SizedBox(height: 3,),
                    OrganisationDetailsItem(icon: Icons.phone_outlined, text: organisation.phone),
                    SizedBox(height: 3,),
                    OrganisationDetailsItem(icon: Icons.mail_outline, text: organisation.email),
                    SizedBox(height: 3,),
                    OrganisationDetailsItem(icon: Icons.web, text: organisation.website),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      print(organisation.address);
                      openGoogleMaps(organisation.address);
                    },
                    child: Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                          color: GlobalColors.mainColor,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Map ",
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily:"semiBold",
                                color: Colors.white
                            ),
                          ),
                          Icon(Icons.location_on, color: Colors.white,size: 15,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: (){
                      _showService(context);
                    },
                    child: Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                        color: GlobalColors.mainColor,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Service",
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily:"semiBold",
                              color: Colors.white
                            ),
                          ),
                          Icon(Icons.arrow_right_alt, color: Colors.white,)
                        ],
                      ),
                    ),
                  ),

                ],
              )
            ],
          )
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }

  void _showService(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ServiceDialog(organisation.name, organisation.services);// Use your custom dialog widget here
      },
    );
  }

  void _showDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteDialog(onItemTap, organisation.id!);// Use your custom dialog widget here
      },
    );
  }
}



