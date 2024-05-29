import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_clone/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/core/urls.dart';
import 'package:netflix_clone/presentation/new_and_hot/widget/coming_soon_tile.dart';
import 'package:netflix_clone/presentation/new_and_hot/widget/everyones_watching_tile.dart';

import 'package:netflix_clone/presentation/widget/custom_icon_button.dart';

import '../widget/app_bar_widget.dart';
import 'widget/new_and_hot_appbar.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryOneIsWatching());
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: NewAndHotAppBarWidget(
            mainWidget: Text(
              "New & Hot",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            //

            // coming soon section

            //

            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<HotAndNewBloc>(context)
                      .add(const LoadDataInComingSoon());
                  BlocProvider.of<HotAndNewBloc>(context)
                      .add(const LoadDataInEveryOneIsWatching());
                },
                child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.hasError) {
                      return const Center(
                        child: Text("Error while loading data"),
                      );
                    } else if (state.comingSoonList.isEmpty) {
                      return const Center(
                        child: Text("Data is empty"),
                      );
                    } else {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final movie = state.comingSoonList[index];
                          if (movie.id == null) {
                            return const SizedBox();
                          }
                          final _date = DateTime.parse(movie.releaseDate ?? '');
                          final formatedDate =
                              DateFormat.yMMMMd('en_US').format(_date);
                          log("date ${movie.releaseDate}");
                          return ComingSoonTile(
                            id: movie.id.toString(),
                            month: formatedDate
                                .split(' ')
                                .first
                                .substring(0, 3)
                                .toUpperCase(),
                            day: movie.releaseDate!.split('-')[2],
                            posterPath: '$imageBaseUrl${movie.backdropPath}',
                            movieName: movie.title ?? 'No title',
                            description: movie.overview ?? 'No description',
                          );
                        },
                        separatorBuilder: (context, index) => kHeight30,
                        itemCount: state.comingSoonList.length,
                      );
                    }
                  },
                ),
              ),
            ),
            //

            // Everyone's watching section

            //
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<HotAndNewBloc>(context)
                      .add(const LoadDataInComingSoon());
                  BlocProvider.of<HotAndNewBloc>(context)
                      .add(const LoadDataInEveryOneIsWatching());
                },
                child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
                  builder: (context, state) {
                    // log("This is state" +
                    //     state.everyOneIsWatchingList.first.posterPath.toString());
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } else if (state.hasError) {
                      return const Center(
                        child: Text("Error while loading data"),
                      );
                    } else if (state.everyOneIsWatchingList.isEmpty) {
                      return const Center(
                        child: Text("Data is empty"),
                      );
                    } else {
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          final movie = state.everyOneIsWatchingList[index];
                          log("everyone element " + movie.toString());
                          log("everyone element " + movie.originalName.toString());
                          if (movie.id == null) {
                            return const SizedBox();
                          }

                          return EveryonesWatchingTile(
                              posterPath: '$imageBaseUrl${movie.backdropPath}',
                              movieName: movie.originalName ?? "title not available",
                              description: movie.overview ?? "no details");
                        },
                        separatorBuilder: (context, index) => kHeight30,
                        itemCount: state.everyOneIsWatchingList.length,
                      );
                    }
                  },
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 10),
            //   child: ListView.separated(
            //     itemBuilder: (context, index) {
            //       final movie = state.comingSoonList[index];
            //       return EveryonesWatchingTile(

            //         posterPath: 'posterPath',
            //         movieName: movie.title ?? 'No title',
            //         description: "description"),},
            //     separatorBuilder: (context, index) => kHeight30,
            //     itemCount: 5,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
