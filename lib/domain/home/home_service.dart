import 'package:dartz/dartz.dart';
import 'package:netflix_clone/domain/core/failures/main_failure.dart';
import 'package:netflix_clone/domain/hot_and_new/models/hot_and_new_resp.dart';

abstract class HomeService {
  Future<Either<MainFailure, HotAndNewResp>> getHotTamilMovieData();
  // Future<Either<MainFailure, HotAndNewResp>> getData();
}
