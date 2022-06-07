import 'package:dio/dio.dart';

final httpClient = Dio(
  BaseOptions(
    baseUrl: 'http://168.119.173.80:400/api/',
  ),
);

// ..interceptors.add(
//     InterceptorsWrapper(
//       onRequest: (options, handler) {
//         // final authInfo = AuthRepository.authChangeNotifier.value;
//         // if (authInfo != null && authInfo.accessToken.isNotEmpty) {
//         //   options.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';
//         // }
//         // handler.next(options);
//       },
//     ),
//   );
