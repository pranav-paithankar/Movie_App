import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/res/color.dart';
import 'package:movie_app/view/now_playing_movies_view.dart';
import 'package:movie_app/view/top_rated_movies_view.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: currentPageIndex, children: const [
        NowPlayingMovies(),
        TopRatedMovies(),
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
