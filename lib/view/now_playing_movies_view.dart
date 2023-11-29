import 'package:flutter/material.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/res/components/search_field.dart';
import 'package:movie_app/view_model/now_playing_movies_view_model.dart';
import 'package:provider/provider.dart';
import '../data/response/status.dart';
import '../utils/size_config.dart';

class NowPlayingMovies extends StatefulWidget {
  const NowPlayingMovies({super.key});

  @override
  State<NowPlayingMovies> createState() => _NowPlayingMoviesState();

  static fromJson(response) {}
}

class _NowPlayingMoviesState extends State<NowPlayingMovies> {
  Widget build(BuildContext context) {
    NowPlayinMoviesViewModel nowPlayinMoviesViewModel =
        NowPlayinMoviesViewModel();
    @override
    void initSate() {
      nowPlayinMoviesViewModel.fetchNowPlayingMoviesApi();
      super.initState();
    }

    SizeConfig().init(context);

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
      body: ChangeNotifierProvider<NowPlayinMoviesViewModel>(
        create: (BuildContext context) => nowPlayinMoviesViewModel,
        child: Consumer<NowPlayinMoviesViewModel>(builder: (context, value, _) {
          switch (value.nowPlayingMoviesList.status) {
            case Status.LOADING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(
                  child: Text(value.nowPlayingMoviesList.message.toString()));
            case Status.COMPLETED:
              return SizedBox();
            // return ListView.builder(
            //     itemCount: value.nowPlayingMoviesList.,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: ListTile(
            //           leading: Image.network(
            //             "https://image.tmdb.org/t/p/w342" +
            //                 value.nowPlayingMoviesList.data!.results![index]
            //                     .poster_path
            //                     .toString(),
            //             errorBuilder: (context, error, stack) {
            //               return Icon(
            //                 Icons.error,
            //                 color: Colors.red,
            //               );
            //             },
            //             height: 40,
            //             width: 40,
            //             fit: BoxFit.cover,
            //           ),
            //           title: Text(value
            //               .nowPlayingMoviesList.data!.results![index].title
            //               .toString()),
            //           subtitle: Text(value.nowPlayingMoviesList.data!
            //               .results![index].release_date
            //               .toString()),
            //         ),
            //       );
            //     });

            case null:
          }
          return Container();
        }),
      ),
    );
  }
}
