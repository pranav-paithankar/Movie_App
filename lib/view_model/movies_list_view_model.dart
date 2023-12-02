import 'package:flutter/material.dart';
import 'package:movie_app/data/response/api_response.dart';
import 'package:movie_app/repository/movies_list_repository.dart';
import '../model/movies_list_model.dart';
import '../res/app_url.dart';

class MoviesListViewModel with ChangeNotifier {
  final _myRepo = MoviesListRepository();

  var url = AppUrl.nowPlayingMovies;

  ApiResponse<MoviesList> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MoviesList> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchNowPlayingMoviesApi(url) async {
    setMoviesList(ApiResponse.loading());
    await _myRepo.fetchNowPlayingApi(url).then((value) {
      return setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      return setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
