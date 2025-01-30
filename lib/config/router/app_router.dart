import 'package:go_router/go_router.dart';
import 'package:movie_app/view/movie/home_screen.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
      path: '/',
      // nombre asignado al widget/vista
      name: HomeScreen.name,
      builder: (context, date) => const HomeScreen())
]);
