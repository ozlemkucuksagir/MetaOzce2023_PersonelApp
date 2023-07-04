import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import '../Pages/MainScreen/MainScreen.dart';
import '../Pages/Profile/ProfileScreen.dart';
import '../components/const.dart';

class NavigationBarMy extends StatefulWidget {
  int index;
  String? username_u;

  NavigationBarMy({
    required this.username_u,
    this.index = 0,
  });

  @override
  _NavigationBarMyState createState() => _NavigationBarMyState();
}

class _NavigationBarMyState extends State<NavigationBarMy> {
  @override
  void initState() {
    super.initState();
  }

  // bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    final screens = [
      MainScreen(username12: widget.username_u),
      ProfileScreen(),
    ];
    return Scaffold(
      body: screens[widget.index],
      bottomNavigationBar: CurvedNavigationBar(
          index: widget.index,
          backgroundColor: kPrimaryBackColor,
          color: kPrimaryColor,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) => setState(() {
                widget.index = index;
              }),
          items: [
            Icon(
              Icons.home,
              color: Colors.white,
            ),
            Visibility(
              visible: true,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            )
          ]),
    );
  }
}
