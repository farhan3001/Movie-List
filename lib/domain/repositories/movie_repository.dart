import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/models/movie_model.dart';

abstract class MovieRepository {
  Future<List<MovieModel>> getMovies();
}

class MovieRepositoryImpl implements MovieRepository {
  final http.Client client;

  MovieRepositoryImpl({required this.client});

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await client.get(Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?api_key=b031ecd04177e1c9aae4efcb44b3f301&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc',
    ));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['results'];
      return jsonResponse.map((movie) => MovieModel.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
