import 'package:flutter/material.dart';
import '../../domain/entities/movie.dart';

/// Handle Movie item data in Movie list
class MovieListItem extends StatelessWidget {
  final Movie movie;

  const MovieListItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [

          /// --Poster
          Image.network(
            'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            width: 50.0,
            height: 75.0,
            fit: BoxFit.cover,
          ),

          const SizedBox(width: 10.0),

          /// --Movie title and release date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(movie.releaseDate),
                // const SizedBox(height: 5.0),
                // Text('Rating: ${movie.voteAverage}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
