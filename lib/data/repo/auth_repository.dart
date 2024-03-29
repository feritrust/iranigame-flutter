import 'package:flutter/widgets.dart';
import 'package:iranigame/data/common/http_client.dart';
import 'package:iranigame/data/send_sms.dart';
import 'package:iranigame/data/source/auth_data_source.dart';
import 'package:iranigame/data/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

final authRepository = AuthRepository(AuthDataSource(httpClient));

abstract class IAuthRepository {
  Future<SendSms> sendSms(String username, String password);
  Future<void> login(String username, String password);

  Future<SendSms> sendCode(String username, String password, String code);

  Future<void> finalRegistration(
      String fullName, String username, String phone, String password);

  Future<void> signOut();


}

class AuthRepository extends IAuthRepository {
  static final ValueNotifier<String?> authChangeNotifier = ValueNotifier(null);
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);

  @override
  Future<SendSms> sendSms(String username, String password) async =>
      dataSource.sendSms(username, password);

  @override
  Future<SendSms> sendCode(String username, String password, String code) =>
      dataSource.sendCode(username, password, code);

  @override
  Future<void> finalRegistration(String fullName, String username, String phone, String password) async {
    final Token result = await dataSource.finalRegistration(fullName, username, phone, password);
    _persistAuthToken(result);
    debugPrint('finalRegistration: ${result.data.token}');
  }


  Future<void> _persistAuthToken(Token authInfo) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    sharedPreferences.setString("token", authInfo.data.token);
    loadAuthInfo();
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String accessToken = sharedPreferences.getString("token") ?? '';

    if (accessToken.isNotEmpty) {
      authChangeNotifier.value = accessToken;
    }
  }

  @override
  Future<void> login(String username, String password) async{
    final Token result = await dataSource.login(username, password);
    _persistAuthToken(result);
    debugPrint('Login Token is: ${result.data.token}');
  }

  @override
  Future<void> signOut() async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
