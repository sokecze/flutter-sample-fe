import 'package:flutter/material.dart';
import 'package:new_flutter/navigation/router.dart';

class BottomNavBar extends BottomNavigationBar {
  BottomNavBar(BuildContext context, {super.key, required super.currentIndex})
      : super(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              label: 'Messages',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                context.goTo(AppRoute.profile);
                break;
              case 1:
                context.goTo(AppRoute.messages);
                break;
            }
          },
        );
}
