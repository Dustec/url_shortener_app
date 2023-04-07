import '../models/url_alias.dart';

abstract class UrlShortenerSource {
  Stream<UrlAlias> shortUrl(String url);
  Stream<List<UrlAlias>> getSavedUrls();
  Stream<String?> getUrlByAlias(String alias);
  Stream<List<UrlAlias>> saveUrl(UrlAlias urlAlias);
  Stream<List<UrlAlias>> removeUrl(UrlAlias urlAlias);
  void clear();
}
