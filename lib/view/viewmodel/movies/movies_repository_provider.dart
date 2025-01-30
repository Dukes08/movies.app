import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/data/datasource/moviedb_datasource_impl.dart';
import 'package:movie_app/data/repositories/movie_repository_impl.dart';

// este repositorio es inmutable, su trabajo es proveerle de info a los otros providers
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: MoviedbDatasource());
});
