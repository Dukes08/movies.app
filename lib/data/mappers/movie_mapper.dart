import 'package:movie_app/data/models/movieDb/movie_from_moviedb.dart';
import 'package:movie_app/domain/entities/movie.dart';

// recivimos la pelicula con el formato de la  api y la transformamos a la entidad que nuestra app maneja
//esto ayuda a que si lo que retorna la api cambia solo tenemos que cambiarlo aca y no en toda la app, ya que la entity se mantiene igual solo que accede a valores distintos del objeto que viene de la api
class MovieMapper {
  static Movie movieDbToEntity(MovieFromMovieDB moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
          : '',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.backdropPath != '')
          ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
          // este no-poster a la hora de adquierer los datos va a permitir filtrar con el where las peliculas que no tenga poster
          : 'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount);
}
