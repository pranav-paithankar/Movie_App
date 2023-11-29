import 'package:flutter/material.dart';
import 'package:movie_app/data/response/api_response.dart';
import 'package:movie_app/repository/now_playing_movies_repository.dart';

import '../view/now_playing_movies_view.dart';

class NowPlayinMoviesViewModel with ChangeNotifier {
  final _myRepo = NowPlayingMoviesRepository();

  ApiResponse<NowPlayingMovies> nowPlayingMoviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<NowPlayingMovies> response) {
    nowPlayingMoviesList = response;
    notifyListeners();
  }

  Future<void> fetchNowPlayingMoviesApi() async {
    setMoviesList(ApiResponse.loading());
    print("loading");
    await _myRepo.fetchNowPlayingApi().then((value) {
      print("complete $value");
      return setMoviesList(ApiResponse.completed(value as NowPlayingMovies?));
    }).onError((error, stackTrace) {
      print("error $error");
      return setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
