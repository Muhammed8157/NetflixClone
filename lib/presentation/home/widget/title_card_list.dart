import 'package:flutter/material.dart';

import '../../../core/constants.dart';

import '../../widget/main_image_card.dart';
import '../../widget/title.dart';

// final image = "https://tse2.mm.bing.net/th?id=OIP.pBtvvAGh8Je5H5f4eKaIrQHaLB&pid=Api&P=0";

class TitleAndCardList extends StatelessWidget {
  const TitleAndCardList({Key? key, required this.title, required this.posterList})
      : super(key: key);

  final title;
  final List<String> posterList;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(title: title),
        kHeight,
        LimitedBox(
          maxHeight: screenWidth * 0.42,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  MainImageCard(height: 0.42, width: 0.28, image: posterList[index]),
              separatorBuilder: (context, index) => kWidth,
              itemCount: 10),
        )
      ],
    );
  }
}
