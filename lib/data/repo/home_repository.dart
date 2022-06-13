import 'package:iranigame/data/common/http_client.dart';
import 'package:iranigame/data/product_category.dart';
import 'package:iranigame/data/source/home_data_source.dart';

final homeRepository = HomeRepository(HomeDataSource(httpClient));

abstract class IHomeRepository extends IHomeDataSource{}

class HomeRepository extends IHomeRepository{
  final IHomeDataSource _dataSource;

  HomeRepository(this._dataSource);

  @override
  Future<ProductCategory> getAllProductCategory() {
    return _dataSource.getAllProductCategory();
  }
}