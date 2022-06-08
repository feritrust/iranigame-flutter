import 'package:iranigame/data/common/http_client.dart';
import 'package:iranigame/data/send_sms.dart';
import 'package:iranigame/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthDataSource(httpClient));

abstract class IAuthRepository{
  Future<SendSms> sendSms(String username,String password);
  Future<SendSms> sendCode(String username,String password,String code);
}

class AuthRepository extends IAuthRepository{
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);
  @override
  Future<SendSms> sendSms(String username, String password) async => dataSource.sendSms(username, password);

  @override
  Future<SendSms> sendCode(String username, String password, String code) => dataSource.sendCode(username, password, code);

}