import 'package:dio/dio.dart';
import 'package:iranigame/common/exception.dart';

mixin HttpResponseValidator{
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}