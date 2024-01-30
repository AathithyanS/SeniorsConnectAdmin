import 'package:seniors_connect/utils/global.color.dart';
import 'package:flutter/material.dart';

class ButtonForm extends StatelessWidget {
  const ButtonForm({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GlobalColors.mainColor,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Text(
          text.toUpperCase(),
          style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: "Medium"
        ),
      ),
    );
  }
}
