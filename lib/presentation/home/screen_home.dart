import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/home/home_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/core/urls.dart';
import 'package:netflix_clone/presentation/search/widget/search_result.dart';
import 'package:netflix_clone/presentation/widget/app_bar_widget.dart';
import 'package:netflix_clone/presentation/widget/main_image_card.dart';
import 'package:netflix_clone/presentation/widget/title.dart';
import 'package:outlined_text/outlined_text.dart';

import 'widget/background_image_card.dart';
import 'widget/homeAppbar_widget.dart';
import 'widget/numbered_title_card_list.dart';
import 'widget/title_card_list.dart';
import 'package:flutter/rendering.dart';

ValueNotifier<bool> appBarWidgetVisisbilityListener = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          NotificationListener<UserScrollNotification>(
            onNotification: ((notification) {
              final ScrollDirection scrollDirection = notification.direction;
              if (scrollDirection == ScrollDirection.forward) {
                appBarWidgetVisisbilityListener.value = true;
              } else if (scrollDirection == ScrollDirection.reverse) {
                appBarWidgetVisisbilityListener.value = false;
              }

              return true;
            }),
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                } else if (state.trendingMovieList.isEmpty) {
                  return const Center(
                    child: Text(
                      "List empty",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else if (state.hasError) {
                  return const Center(
                    child: Text(
                      "Error while loading",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                // released past year
                final _releasedPastYear = state.pastYearMovieList.map((m) {
                  return "$imageBaseUrl${m.posterPath}";
                }).toList();
                // _releasedPastYear.shuffle();

                // trending

                final _trending = state.trendingMovieList.map((m) {
                  return "$imageBaseUrl${m.posterPath}";
                }).toList();

                //tense dramas
                final _tenseDramas = state.tenseDramasMovieList.map((m) {
                  return "$imageBaseUrl${m.posterPath}";
                }).toList();
                _tenseDramas.shuffle();

                //south indian movies
                final _southIndianMovies = state.southIndianMovieList.map((m) {
                  return "$imageBaseUrl${m.posterPath}";
                }).toList();
                _southIndianMovies.shuffle();

                // top 10 tv shows
                final _top10TvShows = state.trendingTvList.map((t) {
                  return "$imageBaseUrl${t.posterPath}";
                }).toList();
                _top10TvShows.shuffle();

                return ListView(
                  children: [
                    BackgroundImageCard(),
                    TitleAndCardList(
                      title: "Released in the past",
                      posterList: _releasedPastYear.sublist(0, 10),
                    ),
                    kHeight20,
                    TitleAndCardList(
                      title: "Trending Now",
                      posterList: _trending.sublist(0, 10),
                    ),
                    kHeight20,
                    NumberedTitleCardList(
                      posterList: _top10TvShows,
                    ),
                    kHeight20,
                    TitleAndCardList(
                      title: "Tense Dramas",
                      posterList: _tenseDramas.sublist(0, 10),
                    ),
                    kHeight20,
                    TitleAndCardList(
                      title: "South Indian Cinima",
                      posterList: _southIndianMovies.sublist(0, 10),
                    ),
                  ],
                );
              },
            ),
          ),

          // App bar

          ValueListenableBuilder(
              valueListenable: appBarWidgetVisisbilityListener,
              builder: (BuildContext context, bool visible, _) {
                const kAppbarOpacity = 0.2;
                if (visible) {
                  return const HomeAppBarWidget(kAppbarOpacity: kAppbarOpacity);
                } else {
                  return const SizedBox();
                }
              }),
        ],
      ),
    ));
  }
}
