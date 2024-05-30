import '../../domain/entities/movie.dart';

/// Filter JSON object to only have specific data types
class MovieModel extends Movie {
  MovieModel({
    required super.title,
    required super.posterPath,
    required super.releaseDate,
    required super.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      voteAverage: json['vote_average'].toDouble(),
    );
  }
}
