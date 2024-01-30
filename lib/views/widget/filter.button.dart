import 'package:seniors_connect/utils/global.color.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 200,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: GlobalColors.mainColor,
          borderRadius: BorderRadius.circular(5)
      ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontFamily: "regular"
        ),
      ),
    );
  }
}
