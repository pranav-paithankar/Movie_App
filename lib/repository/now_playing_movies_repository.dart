import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/now_playing_movies_model.dart';
import '../res/app_url.dart';

class NowPlayingMoviesRepository {
  BaseApiServices _apiServices = NetworkApiService();
  // ignore: prefer_typing_uninitialized_variables
  var url;

  Future<NowPlayingMovies> fetchNowPlayingApi(url) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(url);

      return response = NowPlayingMovies.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
