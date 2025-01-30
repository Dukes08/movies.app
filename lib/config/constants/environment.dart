import 'package:flutter_dotenv/flutter_dotenv.dart';

// reduce el error de escribir mal la variable de entorno al tener una sintaxis compleja

class Environment {
  static String movieDbKey = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay key';
}
