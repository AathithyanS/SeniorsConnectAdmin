import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:ionicons/ionicons.dart';

class ServiceDialog extends StatelessWidget {
  ServiceDialog(this.title, this.data);
  final String title;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        height: 300,
        width: 350,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(width: 40,),
                Expanded(
                    child: Text(
                      title,
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      data,
                      style: TextStyle(
                        fontFamily: "regular",
                        fontSize: 14,
                        color: GlobalColors.textColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}