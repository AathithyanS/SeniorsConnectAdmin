import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/firebase.services.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:ionicons/ionicons.dart';
import 'package:seniors_connect/views/widget/delete.button.dart';

class DeleteDialog extends StatelessWidget {
  DeleteDialog(this.onItemTap, this.id);
  
  final VoidCallback onItemTap;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // padding: EdgeInsets.symmetric(vertical: 300, horizontal: 30),
      child: Container(
        height: 260,
        width: 350,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(width: 40,),
                Expanded(
                    child: Text(
                      "Delete the organisation",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: GlobalColors.mainColor,
                          fontSize: 15,
                          fontFamily: "semiBold"
                      ),
                    )
                ),
                IconButton(
                  icon: Icon(
                    Ionicons.close_circle_outline,
                    color: GlobalColors.mainColor,
                  ),
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            Text(
              "Do you want to delete this organisation?",
              style: TextStyle(
                fontFamily: "regular",
                fontSize: 14,
                color: GlobalColors.textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 25,),
            TextButton(
                onPressed: () async{
                  Navigator.of(context).pop();
                  await FirebaseServices.deleteOrganisationById(id);
                  onItemTap();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 250,
                  height: 40,
                  decoration: BoxDecoration(
                    color: GlobalColors.mainColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "medium",
                      fontSize: 15
                    ),
                  )
                )
            ),
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                    alignment: Alignment.center,
                    width: 250,
                    height: 40,
                    decoration: BoxDecoration(
                        color: GlobalColors.mainColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "medium",
                          fontSize: 15
                      ),
                    )
                )
            )
          ],
        ),
      ),
    );
  }
}