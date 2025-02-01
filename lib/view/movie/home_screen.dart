import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/view/viewmodel/movies/initial_loading_provider.dart';
import 'package:movie_app/view/viewmodel/movies/movies_providers.dart';
import 'package:movie_app/view/viewmodel/movies/movies_slideshow_provider.dart';
import 'package:movie_app/view/widgets/movies/movies_horizontal_listview.dart';
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
    //  esto hace el fetch de las peliculas a penas se renderice el componente, para despues acceder a la data con el watch
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    // remplazar esto con un screen bonito
    if (initialLoading) return Text('cargando hp');
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    // Provider con las 6 peliculas
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(title: CustomAppbar()),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MoviesSlideshow(movies: moviesSlideShow),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MoviesHorizontalListview(
                  movies: nowPlayingMovies,
                  title: 'En cines',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
                MoviesHorizontalListview(
                  movies: popularPlayingMovies,
                  title: 'Populares',
                  subTitle: 'Lunes 20',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
              ],
            );
          }, childCount: 1),
        )
      ],
    );
  }
}
