import 'package:flutter/material.dart';
import 'package:movie_app/view_model/movies_list_view_model.dart';
import 'package:provider/provider.dart';
import '../../model/movies_list_model.dart';
import '../../view_model/Serach_Bar_Provider.dart';
import 'common_list_tile.dart';

class CommonListView extends StatefulWidget {
  const CommonListView(
      {super.key, required this.nowPlayingMovies, required this.onDissmiss});

  final MoviesList nowPlayingMovies;

  final Function(int index) onDissmiss;

  @override
  State<CommonListView> createState() => _CommonListViewState();
}

class _CommonListViewState extends State<CommonListView> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<MoviesListViewModel, SearchBarProvider>(
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
            child: MovieListTile(movie: movie),
          );
        },
      );
    });
  }
}
