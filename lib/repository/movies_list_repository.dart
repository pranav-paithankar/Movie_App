import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiService.dart';
import '../model/movies_list_model.dart';

class MoviesListRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  // ignore: prefer_typing_uninitialized_variables
  var url;

  Future<MoviesList> fetchNowPlayingApi(url) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(url);

      return response = MoviesList.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
