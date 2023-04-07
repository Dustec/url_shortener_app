import '../../../core/domain/managers/http_manager.dart';
import '../../../core/remote/remote_constants.dart';

import '../../../core/domain/contracts/mapper.dart';
import '../domain/models/url_alias.dart';
import '../domain/sources/url_shortener_source.dart';
import 'mappers/url_alias_from_dto_mapper.dart';
import 'models/url_alias_dto.dart';

class UrlShortenerRemoteSource implements UrlShortenerSource {
  UrlShortenerRemoteSource({
    required HttpManager httpManager,
    this.aliasMapper = const UrlAliasFromDtoMapper(),
  }) : _http = httpManager;

  final HttpManager _http;
  final Mapper<UrlAliasDto, UrlAlias> aliasMapper;

  @override
  Stream<UrlAlias> shortUrl(String url) async* {
    yield* _http
        .post(parseShortenerEndpoint('api/alias'), requestBody: {'url': url})
        .handle(mapper: (dynamic json) => UrlAliasDto.fromJson(json))
        .map(aliasMapper.map);
  }

  @override
  Stream<String?> getUrlByAlias(String alias) async* {
    yield* _http.get(parseShortenerEndpoint('api/alias/$alias')).handle(
          mapper: (dynamic json) =>
              (json as Map<String, dynamic>)['url'] as String,
        );
  }

  @override
  Stream<List<UrlAlias>> getSavedUrls() {
    throw UnimplementedError();
  }

  @override
  Stream<List<UrlAlias>> saveUrl(UrlAlias urlAlias) {
    throw UnimplementedError();
  }

  @override
  Stream<List<UrlAlias>> removeUrl(UrlAlias urlAlias) {
    throw UnimplementedError();
  }

  @override
  void clear() {
    throw UnimplementedError();
  }
}
