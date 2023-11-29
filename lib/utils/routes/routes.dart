import 'package:flutter/material.dart';
import 'package:movie_app/view/now_playing_movies_view.dart';
import 'package:movie_app/view/top_rated_movies_view.dart';

import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.now_playing_movies:
        return MaterialPageRoute(
            builder: (BuildContext context) => NowPlayingMovies());

      case RoutesName.top_rated_movies:
        return MaterialPageRoute(
            builder: (BuildContext context) => TopRatedMovies());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
