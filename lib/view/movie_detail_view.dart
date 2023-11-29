import 'package:flutter/material.dart';
import 'package:movie_app/model/now_playing_movies_model.dart';
import 'package:movie_app/res/color.dart';

class MovieDetails extends StatelessWidget {
  MovieDetails({Key? key, required this.movie}) : super(key: key);
  final Results movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
      appBar: AppBar(
        backgroundColor: Color(0xfff4f4f4),
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: movie.id!,
              child: Card(
                elevation: 5,
                child: Container(
                  height: 450,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        "https://image.tmdb.org/t/p/original${movie.backdropPath!}",
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              movie.title!,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildInfoCard(
                    Icons.timer_outlined, movie.voteCount!.toString()),
                buildInfoCard(Icons.calendar_today, movie.releaseDate!),
                buildInfoCard(Icons.star_border, movie.popularity!.toString()),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                movie.overview!,
                style: TextStyle(
                  fontSize: 18,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: [
          buildButton(
            Icons.play_circle_outline,
            'Watch Trailer',
            AppColors.greyColor,
          ),
          buildButton(
            Icons.check_circle_outline,
            'Buy Now',
            AppColors.greyColor,
          ),
        ],
      ),
    );
  }

  Widget buildInfoCard(IconData icon, String text) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 45,
              //color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(IconData icon, String label, Color color) {
    return Expanded(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: () {
          // Implement button functionality here
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
