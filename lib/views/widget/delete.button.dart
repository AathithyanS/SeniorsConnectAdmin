import 'package:seniors_connect/utils/global.color.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        width: 240,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: GlobalColors.mainColor,
            borderRadius: BorderRadius.circular(5)
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: "semiBold"
          ),
        ),
      ),
    );
  }
}
