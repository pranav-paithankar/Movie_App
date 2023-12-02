import 'package:flutter/material.dart';
import 'package:movie_app/model/now_playing_movies_model.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/utils/routes/routes_name.dart';
import 'package:movie_app/view_model/now_playing_movies_view_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/Serach_Bar_Provider.dart';

class CommonListView extends StatefulWidget {
  const CommonListView(
      {super.key, required this.nowPlayingMovies, required this.onDissmiss});

  final NowPlayingMovies nowPlayingMovies;

  final Function(int index) onDissmiss;

  @override
  State<CommonListView> createState() => _CommonListViewState();
}

class _CommonListViewState extends State<CommonListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<NowPlayinMoviesViewModel, SearchBarProvider>(
        builder: (context, value, isSearch, _) {
      return ListView.builder(
        itemCount: widget.nowPlayingMovies.results!.length,
        itemBuilder: (context, index) {
          final movie = widget.nowPlayingMovies.results![index];
          if (isSearch.isSearching &&
              isSearch.searchQuery.isNotEmpty &&
              !movie.title!
                  .toLowerCase()
                  .contains(isSearch.searchQuery.toLowerCase())) {
            return Container();
          }

          return Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) => widget.onDissmiss(index),
            background: Container(
              alignment: AlignmentDirectional.centerEnd,
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.only(right: 18),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  RoutesName.movie_details,
                  arguments: {'movie': movie},
                );
              },
              splashColor: Colors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 120,
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w342${movie.posterPath}",
                              errorBuilder: (context, error, stack) {
                                return const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 8,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(movie.title.toString(),
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 22,
                                      )),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  Text(
                                    movie.overview.toString(),
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    color: AppColors.greyColor,
                    height: 0,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
