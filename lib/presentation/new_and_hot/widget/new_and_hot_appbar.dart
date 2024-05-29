import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';

class NewAndHotAppBarWidget extends StatelessWidget {
  const NewAndHotAppBarWidget({
    Key? key,
    required this.mainWidget,
    this.opacity = 0.0,
  }) : super(key: key);
  final Widget mainWidget;

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kBlackColor.withOpacity(opacity),
      title: mainWidget,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.cast),
          color: Colors.white,
          iconSize: 30,
        ),
        kWidth,
        Container(
          height: 35,
          width: 35,
          color: Colors.blue,
        ),
        kWidth,
      ],
      bottom: TabBar(
          isScrollable: true,
          labelColor: kBlackColor,
          unselectedLabelColor: kWhiteColor,
          labelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          indicator: BoxDecoration(
              color: kWhiteColor, borderRadius: BorderRadius.circular(30)),
          tabs: const [
            Tab(
              text: "🍿 Coming Soon",
            ),
            Tab(
              text: "👀 Everyone's watching",
            ),
          ]),
    );
  }
}
