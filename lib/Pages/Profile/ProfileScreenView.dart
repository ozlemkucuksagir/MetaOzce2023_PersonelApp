import 'package:flutter/material.dart';
import 'package:personel_app/Pages/Login/LoginScreen.dart';
import 'package:personel_app/widgets/feedbackWidget.dart';

import 'components/ProfileMenu.dart';
import 'components/ProfilePic.dart';

class ProfileScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Hesap",
            icon: Icon(
              Icons.person,
            ),
            press: () => {},
          ),
          ProfileMenu(
            text: "Bildirimler",
            icon: Icon(Icons.notifications),
            press: () {},
          ),
          ProfileMenu(
            text: "Ayarlar",
            icon: Icon(Icons.settings),
            press: () {},
          ),
          ProfileMenu(
            text: "Geri Dönüş",
            icon: Icon(Icons.feedback),
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FeedBackWidget())),
          ),
          ProfileMenu(
            text: "Çıkış Yap",
            icon: Icon(Icons.logout),
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen())),
          ),
        ],
      ),
    );
  }
}
