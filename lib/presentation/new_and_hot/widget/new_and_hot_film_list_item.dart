import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';

class NewAndHotFilmListItem extends StatelessWidget {
  NewAndHotFilmListItem(
      {Key? key,
      this.imageHeight = 0.48,
      required this.filmTitle,
      required this.movieImage,
      required this.iconButtons,
      required this.overview,
      this.comingOn = const SizedBox()})
      : super(key: key);

  final double imageHeight;
  final String filmTitle;
  final String movieImage;
  final String overview;
  final Widget iconButtons;
  final Widget comingOn;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: screenWidth * imageHeight,
              child: Image(
                image: NetworkImage(
                  movieImage,
                ),
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  }
                },
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(
                    Icons.network_check,
                    color: Colors.white,
                  ),
                ),
              ),
              // width: screenWidth - 60,
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: kBlackColor.withOpacity(0.5),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.volume_off,
                    color: kWhiteColor,
                    size: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        kHeight,
        Row(
          children: [
            Expanded(
              child: Text(
                filmTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            //Spacer(),
            iconButtons,
          ],
        ),
        comingOn,
        kHeight,
        Row(
          children: [
            SizedBox(
              height: 22,
              width: 22,
              child: Image(image: AssetImage("lib/core/assets/logo.jpg")),
            ),
            Text(
              "FILM",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            )
          ],
        ),
        Text(
          filmTitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        kHeight,
        Text(
          overview,
          style: TextStyle(color: kGreyColor),
        ),
        kHeight
      ],
    );
  }
}
