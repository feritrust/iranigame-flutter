import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iranigame/common/utils.dart';
import 'package:iranigame/data/repo/auth_repository.dart';
import 'package:iranigame/theme.dart';
import 'package:iranigame/ui/auth/auth.dart';
import 'package:iranigame/ui/home/home.dart';
import 'package:iranigame/ui/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle =
        TextStyle(fontFamily: fontName, color: LightThemeColors.primaryColor);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(LightThemeColors.primaryTextColor),
          ),
        ),
        iconTheme: const IconThemeData(color: LightThemeColors.primaryColor),
        scaffoldBackgroundColor: LightThemeColors.secondaryColor,
        hintColor: LightThemeColors.primaryColor,
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: LightThemeColors.primaryTextColor,
            elevation: 0),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: defaultTextStyle.apply(color: Colors.white)),
        textTheme: TextTheme(
          subtitle1: defaultTextStyle.copyWith(
              color: LightThemeColors.primaryColor,
              height: defaultFontLineHeight),
          button: defaultTextStyle.copyWith(height: defaultFontLineHeight),
          bodyText2: defaultTextStyle.copyWith(height: defaultFontLineHeight),
          headline6: defaultTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              height: defaultFontLineHeight),
          caption: defaultTextStyle.copyWith(
              color: LightThemeColors.primaryColor,
              height: defaultFontLineHeight),
        ),
        colorScheme: const ColorScheme.light(
            surfaceVariant: Color(0xfff5f5f5),
            primary: LightThemeColors.primaryColor,
            secondary: LightThemeColors.secondaryColor,
            onSecondary: Colors.white),
      ),
      home: ValueListenableBuilder(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (context, auth, _) {
          if (auth != null) {
            return const Directionality(
              textDirection: TextDirection.rtl,
              child: RootScreen(),
            );
          } else {
            return const Directionality(
              textDirection: TextDirection.rtl,
              child: AuthScreen(),
            );
          }
        },
      )
    );
  }
}
