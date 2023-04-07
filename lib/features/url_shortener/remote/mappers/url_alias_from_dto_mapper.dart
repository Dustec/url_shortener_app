import '../../../../core/domain/contracts/mapper.dart';
import '../../domain/models/url_alias.dart';
import '../models/url_alias_dto.dart';

class UrlAliasFromDtoMapper implements Mapper<UrlAliasDto, UrlAlias> {
  const UrlAliasFromDtoMapper();

  @override
  UrlAlias map(UrlAliasDto t) {
    return UrlAlias(
      alias: t.alias ?? '',
      short: t.links?.short ?? '',
      original: t.links?.self ?? '',
    );
  }
}
