import 'package:go_router/go_router.dart';
import 'package:movie_app/view/movie/home_screen.dart';
import 'package:movie_app/view/movie/movie_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      // nombre asignado al widget/vista
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
      /*
      child routes, esto se hace porque si algun usuario accede directo al link de movie page pueda regresar al estar la ruta conectada a la principal.
      sino se hace esto el usuario si accede directo a un link sin tener un father link se quedare estancado en esa vista      
      */

      routes: [
        GoRoute(
          path: 'movie/:id',
          // nombre asignado al widget/vista
          name: MovieScreen.name,
          builder: (context, state) {
            final movieId = state.pathParameters['id'] ?? 'no-id';
            return MovieScreen(movieId: movieId);
          },
        )
      ]),
]);
