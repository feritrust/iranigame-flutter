import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iranigame/data/product_category.dart';

abstract class IHomeDataSource {
  Future<ProductCategory> getAllProductCategory();
}

class HomeDataSource implements IHomeDataSource {
  final Dio httpClient;

  HomeDataSource(this.httpClient);

  @override
  Future<ProductCategory> getAllProductCategory() async {
    final response = await httpClient.post('cats/list');
    debugPrint('products -> ${response.data}');
    return ProductCategory.fromJson(response.data);
  }
}
