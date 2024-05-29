import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../widget/app_bar_widget.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({
    Key? key,
    required this.kAppbarOpacity,
  }) : super(key: key);

  final double kAppbarOpacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: Column(
        children: [
          AppBarWidget(
            mainWidget: const SizedBox(
                height: 40,
                width: 30,
                child: Image(image: AssetImage("lib/core/assets/logo.jpg"))),
            opacity: kAppbarOpacity,
          ),
          Container(
            color: kBlackColor.withOpacity(kAppbarOpacity),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Text(
                  "TV Shows",
                  style: homeTitleStyle,
                ),
                Text(
                  "Movies",
                  style: homeTitleStyle,
                ),
                Text(
                  "Category",
                  style: homeTitleStyle,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
