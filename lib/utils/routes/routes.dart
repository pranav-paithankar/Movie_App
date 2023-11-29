import 'package:flutter/material.dart';
import 'package:movie_app/view/movie_detail_view.dart';
import 'package:movie_app/view/top_rated_movies_view.dart';
import '../../view/now_playing_movies_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.now_playing_movies:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              NowPlayingMovies(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case RoutesName.top_rated_movies:
        return MaterialPageRoute(
            builder: (BuildContext context) => TopRatedMovies());

      case RoutesName.movie_details:
        final args = settings.arguments as Map<String, dynamic>;

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MovieDetails(
            movie: args["movie"],
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOut;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            var offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

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
