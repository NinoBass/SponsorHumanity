import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/custom_raised_button.dart';

class SigInButton extends CustomRaisedButton {
  SigInButton({
    String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : super(
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 15.0),
          ),
          color: color,
          borderRadius: 8.0,
          height: 40.0,
          onPressed: onPressed,
        ); //super
}
