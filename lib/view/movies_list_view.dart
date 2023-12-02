import 'package:flutter/material.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/res/components/common_listview.dart';
import 'package:movie_app/res/components/search_field.dart';
import 'package:movie_app/view_model/movies_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../data/response/status.dart';

class MoviesListView extends StatefulWidget {
  const MoviesListView({Key? key, this.url}) : super(key: key);
  final String? url;
  @override
  State<MoviesListView> createState() => _MoviesListViewState();
}

class _MoviesListViewState extends State<MoviesListView> {
  MoviesListViewModel nowPlayingMoviesViewModel = MoviesListViewModel();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    nowPlayingMoviesViewModel.fetchNowPlayingMoviesApi(widget.url!);
    super.initState();
  }

  void _onRefresh() async {
    await nowPlayingMoviesViewModel
        .fetchNowPlayingMoviesApi(widget.url!)
        .then((value) => _refreshController.refreshCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.bgLightColor,
        title: const SearchField(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                color: const Color.fromARGB(255, 116, 114, 114),
                height: 1.0,
              ),
            ],
          ),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: ChangeNotifierProvider<MoviesListViewModel>(
          create: (BuildContext context) => nowPlayingMoviesViewModel,
          child: Consumer<MoviesListViewModel>(
            builder: (context, value, _) {
              switch (value.moviesList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child: Text(value.moviesList.message.toString()));
                case Status.COMPLETED:
                  return CommonListView(
                      nowPlayingMovies: value.moviesList.data!,
                      onDissmiss: (index) {
                        setState(() {
                          value.moviesList.data!.results!.removeAt(index);
                        });
                      });

                case null:
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
