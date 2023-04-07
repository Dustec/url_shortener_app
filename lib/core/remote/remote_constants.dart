import '../config/environment.dart';

String parseShortenerEndpoint(String endpoint) {
  return Uri.tryParse('${Environment.baseUrl}$endpoint').toString();
}
