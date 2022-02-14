import 'package:courier/config/allImages.dart';
import 'package:courier/config/appColors.dart';
import 'package:courier/widgets/kText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

Widget customDrawer() {
  return Drawer(
    child: ListView(
      shrinkWrap: true,
      primary: false,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      profile,
                      height: 40,
                      color: green,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      KText(
                        text: 'Fsd',
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      KText(
                        text: 'ID: 41154',
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 50),
              customListTitle(
                // onTap: () => Get.to(BottomBarHome()),
                text: 'Home',
                icons: Ionicons.home_outline,
              ),
              SizedBox(height: 5),
              customListTitle(
                  // onTap: () => Get.to(ProfilePage()),
                  text: 'Profile',
                  icons: Ionicons.person_outline),
              SizedBox(height: 5),
              customListTitle(
                  // onTap: () => Get.to(ProfilePage()),
                  text: 'Settings',
                  icons: Ionicons.settings_outline),
              SizedBox(height: 5),
              customListTitle(
                  // onTap: () => Get.to(SupportPage()),
                  text: 'Support',
                  icons: Ionicons.headset_outline),
            ],
          ),
        ),
        Divider(
          color: Colors.black45,
        ),
        SizedBox(height: 280),
        logoutButton(),
      ],
    ),
  );
}

Widget logoutButton() {
  return Column(
    children: [
      Divider(
        color: Colors.black45,
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10,
        ),
        child: customListTitle(
            text: 'Log Out',
            icons: Ionicons.log_out_outline,
            onTap: () => Get.to(LoginPage())),
      ),
      Divider(
        color: Colors.black45,
      ),
    ],
  );
}

Widget customListTitle({
  String text,
  IconData icons,
  void Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icons,
            color: Colors.black54,
            size: 20,
          ),
          SizedBox(width: 30),
          KText(
            text: text,
            color: black54,
          ),
        ],
      ),
    ),
  );
}
