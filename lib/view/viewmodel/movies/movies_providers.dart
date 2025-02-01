// Importing necessary libraries and files.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod library for state management.
import 'package:movie_app/domain/entities/movie.dart'; // The `Movie` entity from the domain layer.
import 'package:movie_app/view/viewmodel/movies/movies_repository_provider.dart'; // Provider for fetching movie repository.

// A provider that creates and manages an instance of `MoviesNotifier`.
// This provider connects the UI with the `MoviesNotifier`, and the UI gets updated when the state changes.

final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  // con el isLoading hacemos que el usuairo no pueda hacer muchas peticiones al mismo tiempo cuando llegue al final del scroll (con el listener del controller)
  bool isLoading = false;

  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    isLoading = false;
  }
}
