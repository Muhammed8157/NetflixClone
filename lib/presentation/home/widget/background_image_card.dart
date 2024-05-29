import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix_clone/core/colors/colors.dart';

import '../../widget/custom_icon_button.dart';

final mainImage =
    "https://tse2.mm.bing.net/th?id=OIP.qXJE-NDdfaqbUyfJbuazOgHaK6&pid=Api&P=0";

class BackgroundImageCard extends StatelessWidget {
  const BackgroundImageCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          height: screenWidth * 1.35,
          width: screenWidth,
          child: Image(
            image: NetworkImage(
              mainImage,
            ),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              CustomIconButton(
                icon: Icons.add,
                label: "My List",
              ),
              PlayButton(),
              CustomIconButton(icon: Icons.info_outline, label: "Info")
            ],
          ),
        )
      ],
    );
  }
}

// play button for main page background film poster

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(kWhiteColor)),
        onPressed: () {},
        icon: Icon(
          Icons.play_arrow,
          color: kBlackColor,
        ),
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text(
            "Play",
            style: TextStyle(
                color: kBlackColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
