import 'package:flutter/material.dart';
import 'package:movie_app/model/now_playing_movies_model.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/utils/routes/routes_name.dart';
import 'package:provider/provider.dart';

import '../view_model/BottomNavBarProvider.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({Key? key, required this.movie}) : super(key: key);
  final Results movie;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.bgLightColor,
          leadingWidth: 120,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                  ),
                  Text('Back',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  "https://image.tmdb.org/t/p/original${widget.movie.backdropPath!}",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.withOpacity(0.4),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: MediaQuery.of(context).size.width / 1.2,
                  color: Colors.black.withOpacity(0.8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        widget.movie.title.toString(),
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.movie.releaseDate,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 15),
                          const SizedBox(width: 10),
                          Text(
                            widget.movie.voteAverage.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.movie.overview.toString(),
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:
            Consumer<BottomNavBarProvider>(builder: (context, provider, _) {
          return BottomNavigationBar(
            elevation: 1.0,
            selectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedItemColor: Colors.grey,
            backgroundColor: AppColors.bgLightColor,
            currentIndex: provider.currentIndex,
            onTap: (index) {
              provider.updateIndex(index);

              switch (index) {
                case 0:
                  Navigator.of(context)
                      .pushNamed(RoutesName.now_playing_movies);
                  break;
                case 1:
                  Navigator.of(context).pushNamed(RoutesName.top_rated_movies);
                  break;
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie_creation_outlined),
                label: 'Now playing',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border),
                label: 'Top rated',
              ),
            ],
          );
        }));
  }
}
