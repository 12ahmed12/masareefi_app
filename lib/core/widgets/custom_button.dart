import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../theming/colors.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = AppColors.mainColor,
  bool isUpperCase = false,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 55.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          function();
        },
        child: AutoSizeText(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget defaultButtonWithIcon(
        {double width = 200,
        Color background = const Color.fromRGBO(104, 43, 131, 1),
        bool isUpperCase = false,
        int type = 0,
        required Function function,
        required String text,
        required IconData icon}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          function();
        },
        icon: Icon(
          icon,
          color: AppColors.mainColor,
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        label: FittedBox(
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 15.0,
                color: AppColors.mainColor),
          ),
        ),
      ),
    );
