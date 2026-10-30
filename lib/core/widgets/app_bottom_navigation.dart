import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/features/Chat_screen/presentation/pages/chat_screen.dart';
import 'package:easymove/features/Services_screen/presentation/pages/services_screen.dart';
import 'package:easymove/features/homescreen/presentation/pages/home_screen.dart';
import 'package:easymove/features/profile_screen/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({required this.selectedIndex, super.key});

  final int selectedIndex;

  void _handleTap(BuildContext context, int index) {
    if (index == selectedIndex) return;

    final Widget? destination;
    switch (index) {
      case 0:
        destination = const HomeScreen();
      case 1:
        destination = const GetStartedScreen(showBottomNavigation: true);
      case 2:
        destination = const ChatScreen();
      case 4:
        destination = const ProfilePage();
      default:
        destination = null;
    }

    if (destination != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => destination!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => _handleTap(context, index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: HomeColors.bottomBar,
      selectedItemColor: HomeColors.dark,
      unselectedItemColor: HomeColors.muted,
      selectedFontSize: 10,
      unselectedFontSize: 10,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.apps_outlined),
          activeIcon: Icon(Icons.apps),
          label: 'Services',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline),
          activeIcon: Icon(Icons.chat_bubble),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          activeIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
