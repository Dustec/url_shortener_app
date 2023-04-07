import 'package:collection/collection.dart';

import '../../../core/domain/managers/db_manager.dart';
import '../domain/models/url_alias.dart';
import '../domain/sources/url_shortener_source.dart';

class UrlShortenerDbSource implements UrlShortenerSource {
  UrlShortenerDbSource({
    required DbManager<UrlAlias> dbManager,
  }) : _dbManager = dbManager {
    final List<UrlAlias> savedItems = _dbManager.getSavedItems();
    _list.addAll(savedItems);
  }

  final DbManager<UrlAlias> _dbManager;

  final List<UrlAlias> _list = List.empty(growable: true);

  @override
  Stream<String?> getUrlByAlias(String alias) async* {
    if (_list.isEmpty) {
      return;
    }
    final String? url = _list
        .firstWhereOrNull((UrlAlias urlAlias) => alias == urlAlias.alias)
        ?.original;
    if (url == null) {
      return;
    }
    yield url;
  }

  @override
  Stream<List<UrlAlias>> getSavedUrls() async* {
    yield [..._list];
  }

  @override
  Stream<List<UrlAlias>> saveUrl(UrlAlias urlAlias) async* {
    _list.add(urlAlias);
    _dbManager.saveItem(urlAlias);
    yield [..._list];
  }

  @override
  Stream<List<UrlAlias>> removeUrl(UrlAlias urlAlias) async* {
    _list.remove(urlAlias);
    _dbManager.deleteItem(urlAlias);
    yield [..._list];
  }

  @override
  void clear() {
    _dbManager.clear();
  }

  @override
  Stream<UrlAlias> shortUrl(String url) {
    throw UnimplementedError();
  }
}
