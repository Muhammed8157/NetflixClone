import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/home/home_service.dart';
import 'package:netflix_clone/domain/hot_and_new/hot_and_new_service.dart';

import '../../domain/hot_and_new/models/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeServices;
  final HomeService _hservice;
  HomeBloc(this._homeServices, this._hservice) : super(HomeState.initial()) {
    // on event get homescreen data
    on<HomeEvent>((event, emit) async {
      if (state != null) {
        log("state not null");
      }

      log("getting homescreen data");
      //send loading to UI
      emit(state.copyWith(isLoading: true, hasError: false));

      //get data
      final _movieResult = await _homeServices.getHotAndNewMovieData();
      final _tvResult = await _homeServices.getHotAndNewTvData();
      final _tamilMovies = await _hservice.getHotTamilMovieData();

      //transform data

      final _state1 = _movieResult.fold((MainFailure failure) {
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramasMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final pastYear = resp.results;
        final trending = resp.results;
        final dramas = resp.results;
        final southIndian = resp.results;

        pastYear.shuffle();
        trending.shuffle();
        dramas.shuffle();
        southIndian.shuffle();

        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: pastYear,
          trendingMovieList: trending,
          tenseDramasMovieList: dramas,
          southIndianMovieList: southIndian,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          hasError: false,
        );
      });

      emit(_state1);

      final _state2 = _tvResult.fold((MainFailure failure) {
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramasMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final topTenList = resp.results;
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: topTenList,
          tenseDramasMovieList: state.tenseDramasMovieList,
          southIndianMovieList: state.southIndianMovieList,
          trendingTvList: topTenList,
          isLoading: false,
          hasError: false,
        );
      });
      //send to UI

      emit(_state2);

      final _state3 = _tamilMovies.fold((MainFailure failure) {
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramasMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          hasError: true,
        );
      }, (HotAndNewResp resp) {
        final tamilList = resp.results;
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: state.trendingMovieList,
          tenseDramasMovieList: state.tenseDramasMovieList,
          southIndianMovieList: tamilList,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          hasError: false,
        );
      });
      //send to UI

      emit(_state3);
    }
    );
  }
}
