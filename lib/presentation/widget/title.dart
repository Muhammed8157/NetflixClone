import 'package:flutter/material.dart';

import '../../core/colors/colors.dart';

class MainTitle extends StatelessWidget {
  const MainTitle(
      {Key? key, required this.title, this.alignment = TextAlign.start})
      : super(key: key);

  final title;
  final alignment;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: alignment,
      style: TextStyle(
          color: kWhiteColor, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
