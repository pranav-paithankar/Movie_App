import 'package:flutter/material.dart';
import 'package:movie_app/data/response/api_response.dart';
import 'package:movie_app/repository/now_playing_movies_repository.dart';
import '../model/now_playing_movies_model.dart';

class NowPlayinMoviesViewModel with ChangeNotifier {
  final _myRepo = NowPlayingMoviesRepository();

  ApiResponse<NowPlayingMovies> nowPlayingMoviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<NowPlayingMovies> response) {
    nowPlayingMoviesList = response;
    notifyListeners();
  }

  Future<void> fetchNowPlayingMoviesApi() async {
    setMoviesList(ApiResponse.loading());
    await _myRepo.fetchNowPlayingApi().then((value) {
      return setMoviesList(ApiResponse.completed(value as NowPlayingMovies?));
    }).onError((error, stackTrace) {
      return setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
