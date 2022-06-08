import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iranigame/common/utils.dart';
import 'package:iranigame/data/repo/auth_repository.dart';
import 'package:iranigame/ui/auth/auth.dart';
import 'package:iranigame/ui/auth/username/bloc/username_bloc.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({Key? key, required this.username, required this.password})
      : super(key: key);
  final String username;
  final String password;

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  late TextEditingController fullNameController ;

  late TextEditingController usernameController;


  @override
  void initState() {
    fullNameController = TextEditingController();
    usernameController = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: BlocProvider<UsernameBloc>(
          create: (context) {
            final bloc = UsernameBloc(authRepository);
            bloc.stream.listen((state) {
              // if (state is OtpSuccess) {
              // }else if (state is OtpError) {
              //
              // }
            });
            return bloc;
          },
          child: BlocBuilder<UsernameBloc, UsernameState>(
              builder: (context, state) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child: Center(
                child: SingleChildScrollView(
                  physics: defaultScrollPhysics,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: themeData.colorScheme.onSecondary,
                              width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MainBody(themeData: themeData, usernameController: usernameController),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key? key,
    required this.themeData,
    required this.usernameController,
  }) : super(key: key);

  final ThemeData themeData;
  final TextEditingController usernameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'جهت خدمات رسانی بهتر لطفا موارد زیر را پر کنید.',
          style: themeData.textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        CustomInput(
          hintText: 'نام و نام خانوادکی',
          controller: usernameController,
        ),
        const SizedBox(height: 16),
        CustomInput(
          hintText: 'نام کاربری',
          controller: usernameController,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('ثبت نهایی'),
        ),
      ],
    );
  }
}
