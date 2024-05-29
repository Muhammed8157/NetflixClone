import 'package:netflix_clone/core/urls.dart';
import 'package:netflix_clone/infrastructure/api_key.dart';

class ApiEndPoints {
  static const downloads = "$baseUrl/trending/all/day?api_key=$apiKey";
  static const search = "$baseUrl/search/movie?api_key=$apiKey";
  static const hotAndNewMovie = '$baseUrl/discover/movie?api_key=$apiKey';
  static const tamilMovies = "$baseUrl/discover/movie?api_key=$apiKey&with_original_language=ta";

  static const hotAndNewTv = '$baseUrl/discover/tv?api_key=$apiKey';
}

// https://api.themoviedb.org/3/search/movie?api_key=dfcb53d591d4c7069bfd612ef520e8ca&language=en-US&query=spider%20man&page=1&include_adult=false#
