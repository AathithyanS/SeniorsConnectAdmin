import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:ionicons/ionicons.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.controller, required this.text, required this.textInputType, required this.obscure});
  final TextEditingController controller;
  final String text;
  final TextInputType textInputType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.only(top: 0, left: 25, right: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 7
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width-150,
            child: TextFormField(
              controller: controller,
              obscureText: obscure,
              keyboardType: textInputType,
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
                      height: 1
                  )
              ),
            ),
          ),
          Icon(
            Ionicons.search_sharp,
            color: GlobalColors.mainColor,
          )
        ],
      ),
    );
  }
}
