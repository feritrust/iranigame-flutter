import 'package:flutter/material.dart';
import 'package:iranigame/data/repo/auth_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ElevatedButton(
          child: Text('Sign Out'),
          onPressed: () {
            authRepository.signOut();
          },
        ),
      ),
    );
  }
}
