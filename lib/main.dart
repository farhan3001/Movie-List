import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'domain/repositories/movie_repository.dart';
import 'domain/use_case/get_movies.dart';
import 'presentation/blocs/movies_bloc.dart';
import 'presentation/pages/movie_list_page.dart';

void main() {
  final movieRepository = MovieRepositoryImpl(client: http.Client());
  final getMovies = GetMovies(movieRepository);

  runApp(WikiMovies(getMovies: getMovies));
}

class WikiMovies extends StatelessWidget {
  final GetMovies getMovies;

  const WikiMovies({super.key, required this.getMovies});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => MovieBloc(getMovies)..add(FetchMovies()),
        child: const MovieListPage(),
      ),
    );
  }
}