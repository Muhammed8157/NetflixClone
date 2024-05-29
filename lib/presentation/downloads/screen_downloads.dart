import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/downloads/downloads_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/core/urls.dart';
import 'package:netflix_clone/presentation/downloads/widgets/downloads_image_card.dart';

import 'package:netflix_clone/presentation/widget/app_bar_widget.dart';
import 'package:netflix_clone/presentation/widget/main_image_card.dart';
import 'package:netflix_clone/presentation/widget/title.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({Key? key}) : super(key: key);

  List _listOfSections = [
    const _SmartDownloadsSection(),
    _CenterSection(),
    const _BottomButtonsSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: AppBarWidget(
              mainWidget: Text(
                "Downloads",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
              ),
            )),
        body: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => _listOfSections[index],
            separatorBuilder: (context, index) => const SizedBox(
                  height: 20,
                ),
            itemCount: _listOfSections.length));
  }
}

class _SmartDownloadsSection extends StatelessWidget {
  const _SmartDownloadsSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        kWidth,
        Icon(
          Icons.settings,
          color: kWhiteColor,
        ),
        kWidth,
        Text(
          "Smart Downloads",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class _CenterSection extends StatelessWidget {
  _CenterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        const MainTitle(title: "Introducing Downloads for you"),
        kHeight,
        const Text(
          "We'll download a personalised selection of\nmovies and shows for you, so there's\nalways something to watch on your\ndevice.",
          style: TextStyle(fontSize: 16, color: kGreyColor),
          textAlign: TextAlign.center,
        ),
        RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<DownloadsBloc>(context)
                .add(const DownloadsEvent.getDownloadsImage());
          },
          child: BlocBuilder<DownloadsBloc, DownloadsState>(
            builder: (context, state) {
              // print("$imageBaseUrl${state.downloads[1].posterPath}");
              // print("state  =  ${state.downloads}");

              return SizedBox(
                height: screenSize.width * 0.8,
                width: screenSize.width,
                child: Center(
                  child: state.isLoading
                      ? CircularProgressIndicator()
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: kGreyColor.withOpacity(.3),
                              radius: screenSize.width * 0.30,
                            ),
                            DownloadsImageCard(
                              height: 0.4,
                              width: 0.3,
                              angle: -18,
                              margin: EdgeInsets.only(
                                right: screenSize.width * 0.38,
                                top: screenSize.width * 0.1,
                              ),
                              image: "$imageBaseUrl${state.downloads[0].posterPath}",
                            ),
                            DownloadsImageCard(
                              height: 0.4,
                              width: 0.3,
                              angle: 18,
                              margin: EdgeInsets.only(
                                left: screenSize.width * 0.38,
                                top: screenSize.width * 0.1,
                              ),
                              image: "$imageBaseUrl${state.downloads[1].posterPath}",
                            ),
                            DownloadsImageCard(
                              height: 0.46,
                              width: 0.32,
                              margin: EdgeInsets.only(
                                top: screenSize.width * 0.05,
                              ),
                              image: "$imageBaseUrl${state.downloads[2].posterPath}",
                            ),
                          ],
                        ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// "$imageBaseUrl${state.downloads[1].posterPath}"

class _BottomButtonsSection extends StatelessWidget {
  const _BottomButtonsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          width: screenSize.width * 0.85,
          height: 40,
          child: MaterialButton(
            color: kButtonColorBlue,
            onPressed: () {},
            child: const Text(
              "Set Up",
              style: TextStyle(
                  color: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
        kHeight,
        SizedBox(
          height: 40,
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            color: kButtonColorWhite,
            onPressed: () {},
            child: const Text(
              "See What You Can Download",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }
}
