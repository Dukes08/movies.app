import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/view/viewmodel/movies/movies_providers.dart';
import 'package:movie_app/view/widgets/movies/movies_slideshow.dart';

// ref mantiene referencia a todos los providers creados, es decir, se pueden acceder a traves de ref

// provider para mostrar 6 peliculas en el slideshow
final moviesSlideShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
  if (nowPlayingMovies.isEmpty) {
    return [];
  }
  return nowPlayingMovies.sublist(0, 6);
});
