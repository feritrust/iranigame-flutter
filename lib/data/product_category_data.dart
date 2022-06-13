import 'package:json_annotation/json_annotation.dart';

part 'product_category_data.g.dart';

@JsonSerializable()
class ProductCategoryData {
  final int? id;
  final String? name;
  final String? hint;
  final String? img;
  final String? parent_id;
  final String? created_at;
  final String? updated_at;
  final List<ProductCategoryData> children;
  ProductCategoryData(this.id, this.name, this.hint, this.img, this.parent_id, this.created_at, this.updated_at, this.children);
  factory ProductCategoryData.fromJson(Map<String, dynamic> json) => _$ProductCategoryDataFromJson(json);


}