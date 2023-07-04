import 'package:flutter/material.dart';

import '../../components/backgraund.dart';
import 'MainScreenView.dart';

class MainScreen extends StatefulWidget {
  final String? username12;
  const MainScreen({required this.username12});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Background(
      title: "GOREVLER",
      child: MainScreenView(username: widget.username12),
    );
  }
}
