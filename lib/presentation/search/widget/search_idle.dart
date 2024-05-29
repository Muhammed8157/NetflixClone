import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/core/urls.dart';

import '../../widget/title.dart';

class SearchIdleWidget extends StatelessWidget {
  const SearchIdleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MainTitle(
          title: "Top Searches",
        ),
        kHeight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text("Error while loading!"),
                );
              } else if (state.idleList.isEmpty) {
                return const Center(
                  child: Text("Error while loading!"),
                );
              }
              return ListView.separated(
                itemBuilder: (context, index) {
                  print(state);
                  final movie = state.idleList[index];

                  return _TopSearchItemTile(
                      title: movie.title ?? movie.name ?? "No Title",
                      imageUrl: '$imageBaseUrl${movie.backdropPath}');
                },
                separatorBuilder: (context, index) => kHeight,
                itemCount: state.idleList.length,
              );
            },
          ),
        )
      ],
    );
  }
}

class _TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const _TopSearchItemTile(
      {Key? key, required this.title, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: screenWidth * 0.2,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    imageUrl,
                  ))),
        ),
        kWidth,
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Icon(
          Icons.play_circle_outline_sharp,
          color: kWhiteColor,
          size: 50,
        )
      ],
    );
  }
}
