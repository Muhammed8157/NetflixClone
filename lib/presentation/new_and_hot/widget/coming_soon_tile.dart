import 'package:flutter/material.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/presentation/new_and_hot/widget/new_and_hot_film_list_item.dart';
import 'package:netflix_clone/presentation/widget/custom_icon_button.dart';

import '../../../core/constants.dart';

class ComingSoonTile extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonTile({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            width: 50,
            child: Column(
              children: [
                Text(
                  month,
                  style: TextStyle(fontSize: 15, color: kGreyColor),
                ),
                Text(
                  day,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            )),
        Expanded(
          child: NewAndHotFilmListItem(
            filmTitle: movieName,
            movieImage: posterPath,
            iconButtons: ComingSoonIconButtons(),
            comingOn: Text(
              "Coming on $day    $month",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            overview: description,
          ),
        )
      ],
    );
  }
}

class ComingSoonIconButtons extends StatelessWidget {
  const ComingSoonIconButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        CustomIconButton(
          icon: Icons.add_alert,
          label: "Remind Me",
          fontSize: 10,
        ),
        CustomIconButton(
          icon: Icons.info_outline,
          label: "Info",
          fontSize: 10,
        ),
      ],
    );
  }
}
