import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GNav(
          haptic: true, // haptic feedback
          tabBorderRadius: 15,
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: Colors.purple, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor: Colors.purple.withOpacity(0.1),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          tabs: [
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.favorite_outline,
              text: 'Favorites',
            ),
            GButton(
              icon: Icons.account_circle_outlined,
              text: 'Profile',
            )
          ]),
    );
  }
}
