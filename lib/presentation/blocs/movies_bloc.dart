import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/use_case/get_movies.dart';

/// Events -> Get Movies data:
///           1. On app start
///           2. On search result
///           3. On filter result
///
abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

/// 1 On app start
class FetchMovies extends MovieEvent {}

/// 2 and 3 On search + filter result -> merged into 1 interface class
class SearchAndFilterMovies extends MovieEvent {
  final String query;
  final String rating;

  const SearchAndFilterMovies(this.query, this.rating);

  @override
  List<Object> get props => [query, rating];
}

/// States -> States of application:
///           1. Initial state (on app start)
///           2. Loading state
///           3. Data loaded state
///           4. On error state
abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object> get props => [];
}

/// 1. Initial state (on app start)
class MovieInitial extends MovieState {}

/// 2. Loading state
class MovieLoading extends MovieState {}

/// 3. Data loaded state
class MovieLoaded extends MovieState {
  final List<Movie> movies;

  const MovieLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

/// 4. On error state
class MovieError extends MovieState {
  final String message;

  const MovieError(this.message);

  @override
  List<Object> get props => [message];
}

/// Bloc
class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final GetMovies getMovies;
  List<Movie> _allMovies = [];

  MovieBloc(this.getMovies) : super(MovieInitial()) {

    /// Implement BLoC on app start (get movies)
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        _allMovies = await getMovies();

        /// Emit Movie with rating >= 2
        emit(MovieLoaded(_allMovies.where((movie) => movie.voteAverage > 2).toList()));
      } catch (e) {

        /// Handle error
        emit(MovieError(e.toString()));
      }
    });

    /// Implement BLoC on filter and or search
    on<SearchAndFilterMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        var filteredOrSearchedMovies = _allMovies;

        /// Search by query
        if (event.query.isNotEmpty) {
          filteredOrSearchedMovies = filteredOrSearchedMovies.where((movie) =>
              movie.title.toLowerCase().contains(event.query.toLowerCase())).toList();
        }

        /// Filter by rating -> Rating:
        ///                     - Bad: 4 <= rating < 6
        ///                     - Good: 6 <= rating < 8
        ///                     - Great: 8 <= rating < 9
        ///                     - Recommend: rating >= 9
        ///                     - All:  rating >= 2
        switch (event.rating) {
          case 'All':
            filteredOrSearchedMovies = filteredOrSearchedMovies.where((movie) => movie.voteAverage >= 2).toList();
            break;
          case 'Bad':
            filteredOrSearchedMovies = filteredOrSearchedMovies.where((movie) => movie.voteAverage >= 4 && movie.voteAverage < 6).toList();
            break;
          case 'Good':
            filteredOrSearchedMovies = filteredOrSearchedMovies.where((movie) => movie.voteAverage >= 6 && movie.voteAverage < 8).toList();
            break;
          case 'Great':
            filteredOrSearchedMovies = filteredOrSearchedMovies.where((movie) => movie.voteAverage >= 8 && movie.voteAverage < 9).toList();
            break;
          case 'Recommend':
            filteredOrSearchedMovies = filteredOrSearchedMovies.where((movie) => movie.voteAverage >= 9).toList();
            break;
        }

        if (filteredOrSearchedMovies.isEmpty) {

          /// Handle when empty
          emit(const MovieError("Film tidak ditemukan"));
        } else {

          /// Emit filtered or searched Movies
          emit(MovieLoaded(filteredOrSearchedMovies));
        }
      } catch (e) {

        /// Handle error
        emit(MovieError(e.toString()));
      }
    });
  }
}
