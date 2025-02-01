import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_app/config/constants/environment.dart';
import 'package:movie_app/data/mappers/movie_mapper.dart';
import 'package:movie_app/data/models/movieDb/movie_details.dart';
import 'package:movie_app/data/models/movieDb/moviedb_response.dart';
import 'package:movie_app/domain/datasources/movies_datasource.dart';
import 'package:movie_app/domain/entities/movie.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.movieDbKey,
    },
  ));

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDbResponse = MovieDbResponse.fromJson(json);
    // transformamos el objeto de la api a la entidad que manejamos en la app con el mapper
    final List<Movie> movies = movieDbResponse.results
        // el where permite filtrar el array, si la condicion es true pasa al map si es falsa la elimina
        .where((movieDb) => movieDb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // recivimos el json de la api
    final response =
        await dio.get('/movie/now_playing', queryParameters: {'page': page});
    // transformamos el json a un array de objecto MovieDbResponse
    // _jsonToMovies(response.data);

    return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    // recivimos el json de la api
    final response =
        await dio.get('/movie/popular', queryParameters: {'page': page});
    // transformamos el json a un array de objecto MovieDbResponse
    // _jsonToMovies(response.data);

    return _jsonToMovies(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get('/movie/$id');
    if (response.statusCode != 200) {
      throw Exception('Movie with id: $id not found');
    }

    final movieDetails = MovieDetails.fromJson(response.data);
    final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
    return movie;
  }
}
