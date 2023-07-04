import 'package:flutter/material.dart';

import 'const.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String? title;
  const Background({
    Key? key,
    required this.child,
    required this.title,
    this.topImage = "assets/logo/logo.png",
    this.bottomImage = "assets/logo/back3.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${title}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryColor,
      ),
      // bottomNavigationBar:
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 60,
            bottom: 0,
            child: Image.asset(
              bottomImage,
            ),
            height: 1000,
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
