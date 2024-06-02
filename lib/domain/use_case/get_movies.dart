import '../../data/repositories/movie_repository.dart';
import '../../domain/entities/movie.dart';

/// Movie Interface
class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getMovies();
  }
}
