import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({Key? key, required this.mainWidget, this.opacity = 0.0})
      : super(key: key);
  final Widget mainWidget;

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBlackColor.withOpacity(opacity),
      child: Row(
        children: [
          kWidth,
          mainWidget,
          Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.cast),
            color: Colors.white,
            iconSize: 30,
          ),
          kWidth,
          Container(
            height: 30,
            width: 30,
            color: Colors.blue,
          ),
          kWidth
        ],
      ),
    );
  }
}
