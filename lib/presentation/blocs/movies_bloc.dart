import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/use_case/get_movies.dart';
import '../../domain/entities/movie.dart';

// Events
abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class FetchMovies extends MovieEvent {}

class FetchMoviesCount extends MovieEvent {}

class SearchAndFilterMovies extends MovieEvent {
  final String query;
  final String rating;

  const SearchAndFilterMovies(this.query, this.rating);

  @override
  List<Object> get props => [query, rating];
}

// States
abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;
  List<Movie> _allMovies = [];

  MovieBloc(this.getMovies) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        _allMovies = await getMovies();
        emit(MovieLoaded(_allMovies));
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });

    on<SearchAndFilterMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        var filteredMovies = _allMovies;

        // Filter by search query
        if (event.query.isNotEmpty) {
          filteredMovies = filteredMovies.where((movie) =>
              movie.title.toLowerCase().contains(event.query.toLowerCase())).toList();
        }

        // Filter by rating
        switch (event.rating) {
          case 'Bad':
            filteredMovies = filteredMovies.where((movie) => movie.voteAverage >= 4 && movie.voteAverage < 6).toList();
            break;
          case 'Good':
            filteredMovies = filteredMovies.where((movie) => movie.voteAverage >= 6 && movie.voteAverage < 8).toList();
            break;
          case 'Great':
            filteredMovies = filteredMovies.where((movie) => movie.voteAverage >= 8 && movie.voteAverage < 9).toList();
            break;
          case 'Recommend':
            filteredMovies = filteredMovies.where((movie) => movie.voteAverage >= 9).toList();
            break;
        }

        if (filteredMovies.isEmpty) {
          emit(const MovieError("Film tidak ditemukan"));
        } else {
          emit(MovieLoaded(filteredMovies));
        }
      } catch (e) {
        emit(MovieError(e.toString()));
      }
    });
  }
}
