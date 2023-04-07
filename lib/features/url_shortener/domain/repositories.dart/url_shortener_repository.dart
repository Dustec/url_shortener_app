import 'package:rxdart/rxdart.dart';

import '../../../../core/domain/errors/errors.dart';
import '../models/url_alias.dart';
import '../sources/url_shortener_source.dart';

abstract class UrlShortenerRepository {
  Stream<List<UrlAlias>> getSavedUrls();
  Stream<List<UrlAlias>> shortUrl(String url);
  Stream<List<UrlAlias>> getUrlByAlias(String alias);
  void clearRecentUrls();
}

class UrlShortenerDataRepository implements UrlShortenerRepository {
  UrlShortenerDataRepository({
    required UrlShortenerSource dbSource,
    required UrlShortenerSource remoteSource,
  })  : _dbSource = dbSource,
        _remoteSource = remoteSource;

  final UrlShortenerSource _dbSource;
  final UrlShortenerSource _remoteSource;

  @override
  Stream<List<UrlAlias>> getSavedUrls() async* {
    yield* _dbSource.getSavedUrls();
  }

  @override
  Stream<List<UrlAlias>> shortUrl(String url) async* {
    yield* _remoteSource.shortUrl(url).asyncExpand(
      (urlAlias) async* {
        yield* _dbSource.saveUrl(urlAlias);
      },
    );
  }

  @override
  Stream<List<UrlAlias>> getUrlByAlias(String alias) async* {
    yield* _dbSource
        .getUrlByAlias(alias)
        .switchIfEmpty(_remoteSource.getUrlByAlias(alias))
        .asyncExpand(
      (String? original) async* {
        if (original == null) {
          throw UrlAliasNotFound();
        }

        yield* _dbSource.saveUrl(
          UrlAlias(
              alias: alias,
              short:
                  'https://url-shortener-server.onrender.com/api/alias/$alias',
              original: original),
        );
      },
    );
  }

  @override
  void clearRecentUrls() {
    _dbSource.clear();
  }
}
