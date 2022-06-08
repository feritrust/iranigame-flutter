import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranigame/common/utils.dart';
import 'package:iranigame/data/repo/auth_repository.dart';
import 'package:iranigame/theme.dart';
import 'package:iranigame/ui/auth/bloc/auth_bloc.dart';
import 'package:iranigame/ui/auth/otp/otp.dart';
import 'package:iranigame/ui/widgets/default_loading.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final TextEditingController username =
        TextEditingController(text: '09398300660');
    final TextEditingController password =
        TextEditingController(text: '123456');
    final TextEditingController repeatPassword =
        TextEditingController(text: '123456');
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<AuthBloc>(
          create: (context) {
            final bloc = AuthBloc(authRepository: authRepository);
            bloc.add(AuthStarted());
            bloc.stream.listen((state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('کد ارسال شد'),
                  ),
                );
                Future.delayed(const Duration(seconds: 1));
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(username: username.text, password: password.text),
                  ),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.exception.message),
                  ),
                );
              }
            });
            return bloc;
          },
          child: Padding(
              padding: const EdgeInsets.only(left: 48, right: 48),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return Center(
                    child: SingleChildScrollView(
                      physics: defaultScrollPhysics,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: themeData.colorScheme.onSecondary,
                                  width: 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  state.isLoginMode
                                      ? LoginScreen(
                                          username: username,
                                          password: password,
                                        )
                                      : SignUpScreen(
                                          username: username,
                                          password: password,
                                          repeatPassword: repeatPassword,
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key? key,
    required this.username,
    required this.password,
  }) : super(key: key);

  final TextEditingController username;
  final TextEditingController password;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        Text(
          'خوش آمدید به\nایرانی گیم',
          style: themeData.textTheme.headline6!
              .copyWith(fontSize: 24, height: 1.6),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        CustomInput(
          icon: CupertinoIcons.person_alt_circle,
          hintText: 'نام کاربری',
          controller: username,
        ),
        const SizedBox(
          height: 16,
        ),
        CustomInput(
          icon: CupertinoIcons.lock_circle,
          hintText: 'رمز عبور',
          obscureText: true,
          controller: password,
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(onPressed: () {}, child: Text('ورود')),
        ),
        const SizedBox(
          height: 12,
        ),
        TextButton(onPressed: () {}, child: const Text('فراموشی رمز عبور')),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('کاربر جدید هستم!'),
            const SizedBox(
              width: 4,
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(AuthModeChangeIsClicked());
              },
              child: const Text(
                'ثبت نام',
                style: TextStyle(color: LightThemeColors.primaryTextColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    Key? key,
    required this.username,
    required this.password,
    required this.repeatPassword,
  }) : super(key: key);

  final TextEditingController username;
  final TextEditingController password;
  final TextEditingController repeatPassword;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Column(
      children: [
        Text(
          'ثبت نام',
          style: themeData.textTheme.headline6!
              .copyWith(fontSize: 24, height: 1.6),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        CustomInput(
          icon: CupertinoIcons.person_alt_circle,
          hintText: 'شماره موبایل',
          controller: username,
        ),
        const SizedBox(
          height: 16,
        ),
        CustomInput(
          icon: CupertinoIcons.lock_circle,
          hintText: 'رمز عبور',
          obscureText: true,
          controller: password,
        ),
        const SizedBox(
          height: 16,
        ),
        CustomInput(
          icon: CupertinoIcons.lock_circle,
          hintText: ' تکرار رمز عبور',
          obscureText: true,
          controller: repeatPassword,
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'قوانین ایرانی گیم رو مطالعه کرده و قبول میکنم',
          style: themeData.textTheme.caption,
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context)
                  .add(AuthButtonIsClicked(username.text, password.text));
            },
            child: context.watch<AuthBloc>().state is AuthLoading
                ? const DefaultLoading()
                : const Text('مرحله بعدی'),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('دارای حساب کاربری هستم!'),
            const SizedBox(
              width: 4,
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(AuthModeChangeIsClicked());
              },
              child: const Text(
                'ورود',
                style: TextStyle(color: LightThemeColors.primaryTextColor),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput({
    Key? key,
    this.obscureText = false,
    this.icon,
    required this.hintText,
    required this.controller,
  }) : super(key: key);
  final IconData? icon;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 60,
      decoration: BoxDecoration(
          color: LightThemeColors.primaryTextColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              textAlign: TextAlign.center,
              decoration: InputDecoration(hintText: hintText),
            ),
          ),
        ],
      ),
    );
  }
}

/*


 */
