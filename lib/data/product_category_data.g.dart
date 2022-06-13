// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryData _$ProductCategoryDataFromJson(Map<String, dynamic> json) =>
    ProductCategoryData(
      json['id'] as int?,
      json['name'] as String?,
      json['hint'] as String?,
      json['img'] as String?,
      json['parent_id'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      (json['children'] as List<dynamic>)
          .map((e) => ProductCategoryData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductCategoryDataToJson(
        ProductCategoryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hint': instance.hint,
      'img': instance.img,
      'parent_id': instance.parent_id,
      'created_at': instance.created_at,
      'updated_at': instance.updated_at,
      'children': instance.children,
    };
