import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/view/viewmodel/movies/movies_providers.dart';
import 'package:movie_app/view/viewmodel/movies/movies_slideshow_provider.dart';
import 'package:movie_app/view/widgets/movies/movies_slideshow.dart';
import 'package:movie_app/view/widgets/shared/custom_appbar.dart';

class HomeScreen extends StatelessWidget {
  // para las rutas
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _HomeView());
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    // final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    // Provider con las 6 peliculas
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);

    return Column(
      children: [
        CustomAppbar(),
        MoviesSlideshow(movies: moviesSlideShow),
      ],
    );
  }
}
