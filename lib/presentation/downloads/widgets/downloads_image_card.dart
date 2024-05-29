import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/main_image_card.dart';

class DownloadsImageCard extends StatelessWidget {
  const DownloadsImageCard(
      {Key? key,
      required this.height,
      required this.width,
      this.angle = 0,
      this.margin = EdgeInsets.zero,
      required this.image})
      : super(key: key);

  final height;
  final width;
  final angle;
  final margin;
  final image;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    print("Device width in widget ${screenSize.width}");
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: MainImageCard(height: height, width: width, image: image),
      ),
    );
  }
}
