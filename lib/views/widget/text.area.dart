import 'package:seniors_connect/utils/global.color.dart';
import 'package:flutter/material.dart';

class TextArea extends StatelessWidget {
  const TextArea({super.key, required this.controller, required this.text, required this.textInputType, required this.obscure, required this.icon});
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(top: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 7
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: GlobalColors.mainColor,),
          SizedBox(width: 5,),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              keyboardType: textInputType,
              maxLines: 8,
              style: TextStyle(
                  color: GlobalColors.textColor,
                  fontFamily: 'Medium',
                  fontSize: 14
              ),
              decoration: InputDecoration(
                  hintText: text,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(0),
                  hintStyle: TextStyle(
                      color: GlobalColors.hintColor,
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
