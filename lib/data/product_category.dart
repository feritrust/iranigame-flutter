import 'package:iranigame/data/product_category_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_category.g.dart';

@JsonSerializable()
class ProductCategory {
  final bool isDone;
  final List<ProductCategoryData> data;

  ProductCategory(this.isDone, this.data);
  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);
}

