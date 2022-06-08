import 'package:dio/dio.dart';
import 'package:iranigame/data/send_sms.dart';

abstract class IAuthDataSource {
  Future<SendSms> sendSms(String username, String password);

  Future<SendSms> sendCode(String username, String password, String code);
}

class AuthDataSource extends IAuthDataSource {
  final Dio httpClient;

  AuthDataSource(this.httpClient);

  @override
  Future<SendSms> sendSms(String username, String password) async {
    final response = await httpClient.post('register/sendsms',
        data: {"phone": username, "password": password});
    return SendSms.fromJson(response.data);
  }

  @override
  Future<SendSms> sendCode(
      String username, String password, String code) async {
    final response = await httpClient.post('register/sendcode', data: {
      "phone": username,
      "password": password,
      "code": code,
    });
    return SendSms.fromJson(response.data);
  }
}
