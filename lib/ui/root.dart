import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iranigame/data/repo/auth_repository.dart';
import 'package:iranigame/data/repo/home_repository.dart';
import 'package:iranigame/theme.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;
const int sellIndex = 2;
const int chatIndex = 2;

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedTabIndex = homeIndex;
  late PageController _pageController;
  final GlobalKey<NavigatorState> _homeKey = GlobalKey();
  final GlobalKey<NavigatorState> _cartKey = GlobalKey();
  final GlobalKey<NavigatorState> _profileKey = GlobalKey();
  final GlobalKey<NavigatorState> _sellKey = GlobalKey();
  final GlobalKey<NavigatorState> _chatKey = GlobalKey();

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
                  // switch(index) {
                  //   case 0:
                  //     Navigator.
                  // }
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
  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && _selectedTabIndex != index
        ? Container()
        : Navigator(
      key: key,
      onGenerateRoute: (settings) => MaterialPageRoute(
        builder: (context) => Offstage(
          offstage: _selectedTabIndex != index,
          child: child,
        ),
      ),
    );
  }
}
