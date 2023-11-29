import 'package:flutter/material.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/res/components/search_field.dart';
import 'package:movie_app/utils/routes/routes_name.dart';
import 'package:movie_app/view_model/now_playing_movies_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../data/response/status.dart';
import '../view_model/Serach_Bar_Provider.dart';

class NowPlayingMovies extends StatefulWidget {
  const NowPlayingMovies({Key? key}) : super(key: key);

  @override
  State<NowPlayingMovies> createState() => _NowPlayingMoviesState();
}

class _NowPlayingMoviesState extends State<NowPlayingMovies> {
  NowPlayinMoviesViewModel nowPlayingMoviesViewModel =
      NowPlayinMoviesViewModel();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    nowPlayingMoviesViewModel.fetchNowPlayingMoviesApi();
    super.initState();
  }

  void _onRefresh() async {
    // monitor network fetch
    await nowPlayingMoviesViewModel
        .fetchNowPlayingMoviesApi()
        .then((value) => _refreshController.refreshCompleted());
    // if failed,use refreshFailed()
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        title: SearchField(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0),
          child: Column(
            children: [
              SizedBox(
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
        // enablePullUp: true,
        onRefresh: _onRefresh,
        controller: _refreshController,
        child: ChangeNotifierProvider<NowPlayinMoviesViewModel>(
          create: (BuildContext context) => nowPlayingMoviesViewModel,
          child: Consumer2<NowPlayinMoviesViewModel, SearchBarProvider>(
            builder: (context, value, _isSearch, _) {
              switch (value.nowPlayingMoviesList.status) {
                case Status.LOADING:
                  return Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child:
                          Text(value.nowPlayingMoviesList.message.toString()));
                case Status.COMPLETED:
                  return ListView.builder(
                    itemCount: value.nowPlayingMoviesList.data!.results!.length,
                    itemBuilder: (context, index) {
                      final movie =
                          value.nowPlayingMoviesList.data!.results![index];
                      if (_isSearch.isSearching &&
                          !_isSearch.searchQuery.isEmpty &&
                          !movie.title!
                              .toLowerCase()
                              .contains(_isSearch.searchQuery.toLowerCase())) {
                        return Container(); // Skip items that don't match the search query
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RoutesName.movie_details,
                            arguments: {'movie': movie},
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                margin: EdgeInsets.all(0),
                                height: 150, // Adjust the height as needed
                                child: Row(
                                  children: [
                                    Container(
                                      width: 120, // Adjust the width as needed
                                      child: Image.network(
                                        "https://image.tmdb.org/t/p/w342" +
                                            movie.posterPath.toString(),
                                        errorBuilder: (context, error, stack) {
                                          return Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Expanded(
                                      child: ListTile(
                                        title: Container(
                                          margin: EdgeInsets.only(
                                            bottom: 20,
                                          ),
                                          child: Text(
                                            movie.title.toString(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 22,
                                            ),
                                          ),
                                        ),
                                        subtitle: Text(
                                          movie.overview.toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: AppColors
                                  .greyColor, // Customize divider color
                              height: 0, // Adjust divider height
                              thickness: 1, // Adjust divider thickness
                            ),
                          ],
                        ),
                      );
                    },
                  );

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
