import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_app/features/url_shortener/domain/models/url_alias.dart';
import 'package:url_shortener_app/features/url_shortener/remote/mappers/url_alias_from_dto_mapper.dart';
import 'package:url_shortener_app/features/url_shortener/remote/models/url_alias_dto.dart';

void main() {
  group('UrlAliasFromDtoMapperTest', () {
    const UrlAliasFromDtoMapper mapper = UrlAliasFromDtoMapper();

    test('map', () {
      const UrlAliasDto inputStub = UrlAliasDto(
          alias: 'alias',
          links: UrlLinksDto(
            self: 'self',
            short: 'short',
          ));

      const UrlAlias outputStub = UrlAlias(
        alias: 'alias',
        original: 'self',
        short: 'short',
      );

      final result = mapper.map(inputStub);

      expect(result, outputStub);
    });
  });
}
