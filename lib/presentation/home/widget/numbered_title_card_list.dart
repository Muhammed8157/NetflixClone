import 'package:flutter/material.dart';
import 'package:outlined_text/outlined_text.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../widget/main_image_card.dart';
import '../../widget/title.dart';

// final image ="https://tse4.mm.bing.net/th?id=OIP.zp-KPweosXIUdpjMxBDbqgHaKr&pid=Api&P=0";

class NumberedTitleCardList extends StatelessWidget {
  const NumberedTitleCardList({
    Key? key,
    required this.posterList
  }) : super(key: key);

  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: "Top 10 TV Shows in India Today"),
        kHeight,
        LimitedBox(
          maxHeight: screenWidth * 0.42,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: screenWidth * 0.08),
                        child:
                            MainImageCard(height: 0.42, width: 0.28, image: posterList[index]),
                      ),
                      Positioned(
                        bottom: -15,
                        left: 5,
                        child: OutlinedText(
                          text: Text(
                            "${index + 1}",
                            style: TextStyle(
                                color: kBlackColor,
                                fontSize: screenWidth * 0.21,
                                fontWeight: FontWeight.bold),
                          ),
                          strokes: [
                            OutlinedTextStroke(
                                color: kWhiteColor, width: screenWidth * 0.015)
                          ],
                        ),
                      )
                    ],
                  ),
              separatorBuilder: (context, index) => kWidth,
              itemCount: 10),
        )
      ],
    );
  }
}
