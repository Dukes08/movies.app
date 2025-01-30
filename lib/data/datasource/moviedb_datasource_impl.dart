import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:movie_app/config/constants/environment.dart';
import 'package:movie_app/data/mappers/movie_mapper.dart';
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
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    // recivimos el json de la api
    final response = await dio.get('/movie/now_playing');
    // transformamos el json a un array de objecto MovieDbResponse
    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    // transformamos el objeto de la api a la entidad que manejamos en la app con el mapper
    final List<Movie> movies = movieDbResponse.results
        // el where permite filtrar el array, si la condicion es true pasa al map si es falsa la elimina
        .where((movieDb) => movieDb.posterPath != 'no-poster')
        .map((movieDb) => MovieMapper.movieDbToEntity(movieDb))
        .toList();
    return movies;
  }
}
