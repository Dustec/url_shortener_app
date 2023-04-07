// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'url_alias_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UrlAliasDto _$UrlAliasDtoFromJson(Map<String, dynamic> json) => UrlAliasDto(
      alias: json['alias'] as String?,
      links: json['_links'] == null
          ? null
          : UrlLinksDto.fromJson(json['_links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UrlAliasDtoToJson(UrlAliasDto instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      '_links': instance.links,
    };

UrlLinksDto _$UrlLinksDtoFromJson(Map<String, dynamic> json) => UrlLinksDto(
      self: json['self'] as String?,
      short: json['short'] as String?,
    );

Map<String, dynamic> _$UrlLinksDtoToJson(UrlLinksDto instance) =>
    <String, dynamic>{
      'self': instance.self,
      'short': instance.short,
    };
