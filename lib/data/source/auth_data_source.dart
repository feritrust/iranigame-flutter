import 'package:dio/dio.dart';
import 'package:iranigame/data/send_sms.dart';



abstract class IAuthDataSource {
  Future<SendSms> sendSms(String username,String password);
}

class AuthDataSource extends IAuthDataSource{
  final Dio httpClient;

  AuthDataSource(this.httpClient);
  @override
  Future<SendSms> sendSms(String username,String password)async {
      final response = await httpClient.post('register/sendsms',data: {
        "phone":username,
        "password":password
      });
      return SendSms(response.data['isDone'], response.data['data']);
  }

}