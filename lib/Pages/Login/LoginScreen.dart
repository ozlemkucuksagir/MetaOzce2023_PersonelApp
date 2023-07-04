import 'package:flutter/material.dart';

import '../../components/backgraund.dart';
import 'LoginView.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "GİRİŞ YAP",
      child: LoginView(),
    );
  }
}
