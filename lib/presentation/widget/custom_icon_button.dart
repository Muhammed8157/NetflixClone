import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

// custom button with icon and text which is arranged vertically

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key,
      required this.icon,
      required this.label,
      this.fontSize = 20,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  final IconData icon;
  final String label;
  final double fontSize;
  final fontWeight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Column(
        children: [
          Icon(
            icon,
            color: kWhiteColor,
          ),
          Text(
            label,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          )
        ],
      ),
    );
  }
}
