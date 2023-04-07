mixin RemoteConstants {
  static const urlShortenerBaseUrl =
      'https://url-shortener-server.onrender.com/';
}

String parseShortenerEndpoint(String endpoint) {
  return Uri.tryParse('${RemoteConstants.urlShortenerBaseUrl}$endpoint')
      .toString();
}
