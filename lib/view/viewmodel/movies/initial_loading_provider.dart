//mostrar el loader hasta que los providers tenga informacion de la api en sus estados

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/view/viewmodel/movies/movies_providers.dart';

final initialLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(nowPlayingMoviesProvider).isEmpty;
  final step2 = ref.watch(nowPlayingMoviesProvider).isEmpty;

  if (step1 || step2) return true;
  return false;
});
