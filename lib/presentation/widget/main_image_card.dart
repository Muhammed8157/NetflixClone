import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainImageCard extends StatelessWidget {
  const MainImageCard(
      {Key? key,
      required this.height,
      required this.width,
      this.margin = EdgeInsets.zero,
      required this.image})
      : super(key: key);

  final height;
  final width;

  final margin;
  final image;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      height: screenSize.width * height,
      width: screenSize.width * width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(fit: BoxFit.fill, image: NetworkImage(image))),
    );
  }
}
