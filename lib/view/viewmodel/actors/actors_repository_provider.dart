import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/data/datasource/actor_moviedb_datasource.dart';
import 'package:movie_app/data/repositories/actor_repository_impl.dart';

// Este repositorio es inmutable
final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl(ActorMovieDbDatasource());
});
