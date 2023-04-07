import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin Environment {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
}
