import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix_clone/domain/home/home_service.dart';
import 'package:netflix_clone/domain/hot_and_new/models/hot_and_new_resp.dart';

import '../../domain/core/api_end_points.dart';

@LazySingleton(as: HomeService)
class HomeImplementation implements HomeService {
  @override
  Future<Either<MainFailure, HotAndNewResp>> getHotTamilMovieData() async {
    try {
      final response = await Dio().get(
        ApiEndPoints.tamilMovies,
      );
//
      if (response.statusCode == 200 || response.statusCode == 201) {
        // log("Movie................." + response.data.toString());
        final result = HotAndNewResp.fromJson(response.data);

        return right(result);
      } else {
        return const Left(MainFailure.serverFailure());
      }
    } catch (e) {
      log(e.toString());

      return const Left(MainFailure.clientFailure());
    }
  }
}
