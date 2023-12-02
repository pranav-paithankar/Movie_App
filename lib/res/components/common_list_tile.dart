import 'package:flutter/material.dart';
import '../../model/movies_list_model.dart';
import '../../utils/routes/routes_name.dart';
import '../color.dart';

class MovieListTile extends StatelessWidget {
  const MovieListTile({super.key, required this.movie});
  final Movies movie;
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
                                fontSize: 13, fontWeight: FontWeight.w500),
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
    );
  }
}
