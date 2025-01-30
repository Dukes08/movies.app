// Importing necessary libraries and files.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Riverpod library for state management.
import 'package:movie_app/domain/entities/movie.dart'; // The `Movie` entity from the domain layer.
import 'package:movie_app/view/viewmodel/movies/movies_repository_provider.dart'; // Provider for fetching movie repository.

// A provider that creates and manages an instance of `MoviesNotifier`.
// This provider connects the UI with the `MoviesNotifier`, and the UI gets updated when the state changes.
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // Fetch the `getNowPlaying` method from the `movieRepositoryProvider`.
  // This method will be used by `MoviesNotifier` to fetch more movies.
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;

  // Create and return an instance of `MoviesNotifier`, passing the fetch function.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// A type alias for a callback function that fetches a list of movies asynchronously.
// It accepts an optional `page` parameter to specify which page of data to fetch.
typedef MovieCallback = Future<List<Movie>> Function({int page});

// `MoviesNotifier` is a StateNotifier that manages a list of movies.
// It is responsible for handling state updates and fetching more movies when needed.
class MoviesNotifier extends StateNotifier<List<Movie>> {
  // Tracks the current page of movies being displayed.
  int currentPage = 0;

  // A callback function to fetch more movies. This function is passed in when the notifier is created.
  MovieCallback fetchMoreMovies;

  // Constructor for `MoviesNotifier`.
  // It takes the `fetchMoreMovies` callback as a required parameter and initializes the state as an empty list.
  MoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  // A method to load the next page of movies.
  Future<void> loadNextPage() async {
    // Increment the current page number to fetch the next page.
    currentPage++;

    // Call the `fetchMoreMovies` callback to fetch a list of movies for the current page.
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // Update the state by appending the newly fetched movies to the existing list.
    // `state` is the current list of movies managed by the notifier.
    state = [...state, ...movies];
  }
}
