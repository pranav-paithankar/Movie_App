import 'package:flutter/material.dart';
import 'package:movie_app/view/landing_view.dart';
import 'package:movie_app/view/movie_details_view.dart';
import '../../view/movies_list_view.dart';
import '../../view/splash_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.now_playing_movies:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MoviesListView(),
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

      case RoutesName.movie_details:
        final args = settings.arguments as Map<String, dynamic>;

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              MovieDetailsView(
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
      case RoutesName.landing_screen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LandingView());

      case RoutesName.splash_view:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());
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
