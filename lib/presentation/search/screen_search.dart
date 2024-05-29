import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_clone/application/search/search_bloc.dart';
import 'package:netflix_clone/core/colors/colors.dart';
import 'package:netflix_clone/core/constants.dart';
import 'package:netflix_clone/domain/core/debounds/debounce.dart';
import 'package:netflix_clone/presentation/search/widget/search_idle.dart';
import 'package:netflix_clone/presentation/search/widget/search_result.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);

  final _debouncer = Debouncer(milliseconds: 1 * 1000);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    });
    return Column(
      children: [
        CupertinoSearchTextField(
          prefixIcon: const Icon(
            CupertinoIcons.search,
            color: kGreyColor,
          ),
          suffixIcon: const Icon(
            CupertinoIcons.xmark_circle_fill,
            color: kGreyColor,
          ),
          style: const TextStyle(color: kWhiteColor, fontSize: 16),
          onChanged: ((value) {
            _debouncer.run(() {
              if (value.isEmpty) {
                return;
              }
              BlocProvider.of<SearchBloc>(context)
                  .add(SearchMovie(movieQuery: value));
            });
          }),
        ),
        kHeight,
        Expanded(
            child: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<SearchBloc>(context).add(const Initialize());
          },
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.searchResultList.isEmpty) {
                return const SearchIdleWidget();
              } else {
                return const SearchResultWidget();
              }
            },
          ),
        ))
      ],
    );
  }
}
