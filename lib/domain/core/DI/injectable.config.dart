// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../../application/downloads/downloads_bloc.dart' as _i11;
import '../../../application/fast_laugh/fast_laugh_bloc.dart' as _i12;
import '../../../application/home/home_bloc.dart' as _i13;
import '../../../application/hot_and_new/hot_and_new_bloc.dart' as _i14;
import '../../../application/search/search_bloc.dart' as _i15;
import '../../../infrastructure/downloads/downloads_repository.dart' as _i8;
import '../../../infrastructure/home/home_impl.dart' as _i4;
import '../../../infrastructure/hot_and_new/hot_and_new_impl.dart' as _i6;
import '../../../infrastructure/search/search_impl.dart' as _i10;
import '../../downloads/i_downloads_repo.dart' as _i7;
import '../../home/home_service.dart' as _i3;
import '../../hot_and_new/hot_and_new_service.dart' as _i5;
import '../../search/search_service.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.HomeService>(() => _i4.HomeImplementation());
  gh.lazySingleton<_i5.HotAndNewService>(() => _i6.HotAndNewImplementation());
  gh.lazySingleton<_i7.IDownloadsRepo>(() => _i8.DownloadsRepository());
  gh.lazySingleton<_i9.SearchService>(() => _i10.SearchImpl());
  gh.factory<_i11.DownloadsBloc>(
      () => _i11.DownloadsBloc(get<_i7.IDownloadsRepo>()));
  gh.factory<_i12.FastLaughBloc>(
      () => _i12.FastLaughBloc(get<_i7.IDownloadsRepo>()));
  gh.factory<_i13.HomeBloc>(
      () => _i13.HomeBloc(get<_i5.HotAndNewService>(), get<_i3.HomeService>()));
  gh.factory<_i14.HotAndNewBloc>(
      () => _i14.HotAndNewBloc(get<_i5.HotAndNewService>()));
  gh.factory<_i15.SearchBloc>(() =>
      _i15.SearchBloc(get<_i7.IDownloadsRepo>(), get<_i9.SearchService>()));
  return get;
}
