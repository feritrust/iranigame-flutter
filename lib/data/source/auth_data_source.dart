import 'package:dio/dio.dart';
import 'package:iranigame/data/send_sms.dart';
import 'package:iranigame/data/token.dart';

abstract class IAuthDataSource {
  Future<SendSms> sendSms(String username, String password);

  Future<Token> login(String username, String password);

  Future<SendSms> sendCode(String username, String password, String code);

  Future<Token> finalRegistration(
      String fullName, String username, String phone, String password);

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

  @override
  Future<Token> finalRegistration(
      String fullName, String username, String phone, String password) async {
    final response = await httpClient.post('register/username', data: {
      "name": fullName,
      "username": username,
      "phone": phone,
      "password": password
    });
    return Token.fromJson(response.data);
  }

  @override
  Future<Token> login(String username, String password) async {
    final response = await httpClient
        .post('login', data: {"phone": username, "password": password});
    return Token.fromJson(response.data);
  }
}
