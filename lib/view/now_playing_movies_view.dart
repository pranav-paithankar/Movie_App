import 'package:flutter/material.dart';
import 'package:movie_app/res/app_url.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/res/components/common_listview.dart';
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
          child: Consumer<NowPlayinMoviesViewModel>(
            builder: (context, value, _) {
              switch (value.nowPlayingMoviesList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                      child:
                          Text(value.nowPlayingMoviesList.message.toString()));
                case Status.COMPLETED:
                  return CommonListView(
                      nowPlayingMovies: value.nowPlayingMoviesList.data!,
                      onDissmiss: (index) {
                        setState(() {
                          value.nowPlayingMoviesList.data!.results!
                              .removeAt(index);
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
