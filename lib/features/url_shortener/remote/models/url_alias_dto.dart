import 'package:freezed_annotation/freezed_annotation.dart';

part 'url_alias_dto.g.dart';

@JsonSerializable()
class UrlAliasDto {
  const UrlAliasDto({
    this.alias,
    this.links,
  });

  factory UrlAliasDto.fromJson(Map<String, dynamic> json) =>
      _$UrlAliasDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UrlAliasDtoToJson(this);

  final String? alias;
  @JsonKey(name: '_links')
  final UrlLinksDto? links;
}

@JsonSerializable()
class UrlLinksDto {
  const UrlLinksDto({
    this.self,
    this.short,
  });

  factory UrlLinksDto.fromJson(Map<String, dynamic> json) =>
      _$UrlLinksDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UrlLinksDtoToJson(this);

  final String? self;
  final String? short;
}
