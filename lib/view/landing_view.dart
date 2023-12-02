import 'package:flutter/material.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/view/movies_list_view.dart';

import '../res/app_url.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentPageIndex, children: [
        MoviesListView(url: AppUrl.nowPlayingMovies),
        MoviesListView(url: AppUrl.topRatedMovies),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 1.0,
        selectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.bgLightColor,
        currentIndex: currentPageIndex,
        onTap: (index) => changeIndex(index),
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
      ),
    );
  }

  changeIndex(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }
}
