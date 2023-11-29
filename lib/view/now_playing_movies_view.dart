import 'package:flutter/material.dart';
import 'package:movie_app/res/app_url.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/res/components/search_field.dart';
import 'package:movie_app/utils/routes/routes_name.dart';
import 'package:movie_app/view_model/now_playing_movies_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../data/response/status.dart';
import '../view_model/BottomNavBarProvider.dart';
import '../view_model/Serach_Bar_Provider.dart';

class NowPlayingMovies extends StatefulWidget {
  const NowPlayingMovies({Key? key}) : super(key: key);

  @override
  State<NowPlayingMovies> createState() => _NowPlayingMoviesState();
}

class _NowPlayingMoviesState extends State<NowPlayingMovies> {
  NowPlayinMoviesViewModel nowPlayingMoviesViewModel =
      NowPlayinMoviesViewModel();

  var url = AppUrl.nowPlayingMovies;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int _currentIndex = 0;

  @override
  void initState() {
    nowPlayingMoviesViewModel.fetchNowPlayingMoviesApi(url);
    super.initState();
  }

  void _onRefresh() async {
    await nowPlayingMoviesViewModel
        .fetchNowPlayingMoviesApi(url)
        .then((value) => _refreshController.refreshCompleted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.bgLightColor,
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
                        return Container();
                      }

                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) {
                          setState(() {
                            value.nowPlayingMoviesList.data!.results!
                                .removeAt(index);
                          });
                        },
                        background: Container(
                          alignment: AlignmentDirectional.centerEnd,
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 18),
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
                                  margin: EdgeInsets.all(0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 120,
                                        child: Image.network(
                                          "https://image.tmdb.org/t/p/w342" +
                                              movie.posterPath.toString(),
                                          errorBuilder:
                                              (context, error, stack) {
                                            return Icon(
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(movie.title.toString(),
                                                  maxLines: 2,
                                                  style: TextStyle(
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
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
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

                case null:
              }
              return Container();
            },
          ),
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
                Navigator.of(context).pushNamed(RoutesName.now_playing_movies);
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
      }),
    );
  }
}
