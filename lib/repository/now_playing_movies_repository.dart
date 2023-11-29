import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../res/app_url.dart';
import '../view/now_playing_movies_view.dart';

class NowPlayingMoviesRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<NowPlayingMovies> fetchNowPlayingApi() async {
    try {
      dynamic response =
          await _apiServices.getGetApiResponse(AppUrl.nowPlayingMovies);
      print("response $response");
      return response = NowPlayingMovies.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
