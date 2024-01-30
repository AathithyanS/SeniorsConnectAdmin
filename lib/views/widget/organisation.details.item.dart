import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';

class OrganisationDetailsItem extends StatelessWidget {
  const OrganisationDetailsItem({super.key, required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: GlobalColors.mainColor,
        ),
        SizedBox(width: 5,),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: "regular",
                color: GlobalColors.textLightColor,
                fontSize: 11
            ),
          ),
        )
      ],
    );
  }
}
