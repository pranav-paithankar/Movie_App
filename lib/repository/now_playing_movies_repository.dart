import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/now_playing_movies_model.dart';
import '../res/app_url.dart';

class NowPlayingMoviesRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<NowPlayingMovies> fetchNowPlayingApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.nowPlayingMovies);

      return response = NowPlayingMovies.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
