// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetCategoriesRequestImpl _$$GetCategoriesRequestImplFromJson(
  Map<String, dynamic> json,
) => _$GetCategoriesRequestImpl(
  name: $enumDecodeNullable(_$CategoryTypeEnumEnumMap, json['name']),
);

Map<String, dynamic> _$$GetCategoriesRequestImplToJson(
  _$GetCategoriesRequestImpl instance,
) => <String, dynamic>{'name': _$CategoryTypeEnumEnumMap[instance.name]};

const _$CategoryTypeEnumEnumMap = {
  CategoryTypeEnum.daily: 'daily',
  CategoryTypeEnum.productivity: 'productivity',
  CategoryTypeEnum.note: 'note',
};
