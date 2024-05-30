import '../../domain/entities/movie.dart';
import '../repositories/movie_repository.dart';

/// Movie Interface
class GetMovies {
  final MovieRepository repository;

  GetMovies(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getMovies();
  }
}
