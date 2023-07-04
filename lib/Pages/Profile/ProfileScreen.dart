import 'package:flutter/material.dart';

import '../../components/backgraund.dart';
import 'ProfileScreenView.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      title: "Profilim",
      child: ProfileScreenView(),
    );
  }
}
