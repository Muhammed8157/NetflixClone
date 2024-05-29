import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_clone/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final sampleVideoUrls = [
  "https://player.vimeo.com/external/476838909.sd.mp4?s=33e4e8ec8dcd99aefd4eda56737c498ac69c8c1f&profile_id=165&oauth2_token_id=57447761",
  "https://player.vimeo.com/external/484726216.sd.mp4?s=aacaa372a4b3534f0001cbcab048297287ac022d&profile_id=165&oauth2_token_id=57447761",
  "https://player.vimeo.com/external/554290650.hd.mp4?s=9a6934df757bab3a6f173d41627fd7a5f5f7ebd3&profile_id=174&oauth2_token_id=57447761"
];
ValueNotifier<Set<int>> likedVideosIdsNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadsRepo _downloadsService,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      // sending loading to UI
      emit(const FastLaughState(
        videosList: [],
        isLoading: true,
        isError: false,
      ));

      // get trending movie
      final _result = await _downloadsService.getDownloadsImage();
      final _state = _result.fold((l) {
        return FastLaughState(
          videosList: [],
          isLoading: false,
          isError: true,
        );
      }, (resp) {
        return FastLaughState(
          videosList: resp,
          isLoading: false,
          isError: false,
        );
      });

      // get videos

      //show in UI
      emit(_state);
    });

    on<LikeVideo>((event, emit) async {
      likedVideosIdsNotifier.value.add(event.id);
      likedVideosIdsNotifier.notifyListeners();
    });
    on<UnlikeVideo>((event, emit) async {
      likedVideosIdsNotifier.value.remove(event.id);
      likedVideosIdsNotifier.notifyListeners();
    });
  }
}
