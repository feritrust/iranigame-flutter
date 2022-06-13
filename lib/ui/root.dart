import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iranigame/data/repo/auth_repository.dart';
import 'package:iranigame/theme.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedTabIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: AuthRepository.authChangeNotifier,
          builder: (context, auth, _) {
            if (auth != null) {
              return BottomNavyBar(
                backgroundColor: LightThemeColors.secondaryColor,
                selectedIndex: _selectedTabIndex,
                showElevation: true, // use this to remove appBar's elevation
                onItemSelected: (index) {
                  setState(() {
                    _selectedTabIndex = index;

                  });
                },
                items: [
                  BottomNavyBarItem(
                    icon: const Icon(CupertinoIcons.home),
                    title: const Text('خانه'),
                    activeColor: Colors.red,
                  ),
                  BottomNavyBarItem(
                      icon: const Icon(CupertinoIcons.shopping_cart),
                      title: const Text('خرید'),
                      activeColor: Colors.purpleAccent),
                  BottomNavyBarItem(
                      icon: const Icon(CupertinoIcons.plus_circle_fill),
                      title: const Text('فروش'),
                      activeColor: Colors.pink),
                  BottomNavyBarItem(
                      icon: const Icon(CupertinoIcons.chat_bubble_2),
                      title: const Text('چت'),
                      activeColor: Colors.blue),
                  BottomNavyBarItem(
                      icon: const Icon(CupertinoIcons.person),
                      title: const Text('پروفایل'),
                      activeColor: Colors.greenAccent),
                ],
              );
            } else {
              return Container();
            }
          }),
    );
  }
}
