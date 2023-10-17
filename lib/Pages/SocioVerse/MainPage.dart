import 'package:socioverse/Pages/NavbarScreens/staticPagesClass.dart';
import 'package:socioverse/Pages/NavbarScreens/threadPage.dart';
import 'package:socioverse/Pages/SettingsPages/activityPage.dart';
import 'package:socioverse/Pages/NavbarScreens/feedPage.dart';
import 'package:socioverse/Pages/NavbarScreens/pickImagePage.dart';
import 'package:socioverse/Pages/NavbarScreens/searchFeeds.dart';
import 'package:socioverse/Pages/NavbarScreens/userProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:ionicons/ionicons.dart';

class MainPage extends StatefulWidget {
  bool isThread = false;
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavigatorPage.pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.secondary,
              blurRadius: 0.3,
              spreadRadius: 0.3,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.floating,
          height: 70,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          shadowColor: Theme.of(context).colorScheme.onPrimary,
          backgroundColor: Colors.transparent,
          unselectedItemColor: Theme.of(context).colorScheme.tertiary,
          selectedItemColor: Theme.of(context).colorScheme.primary,
          currentIndex: _selectedIndex,
          unselectedLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 2,
              ),
          onTap: (index) => setState(() => _selectedIndex = index),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Ionicons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Ionicons.add_circle,
                size: 50,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Ionicons.notifications_outline),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
                icon: Icon(Ionicons.person_outline), label: 'Account'),
          ],
        ),
      ),
    );
  }
}
