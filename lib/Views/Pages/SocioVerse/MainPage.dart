import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/bottomNavigationProvider.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/staticPagesClass.dart';

class MainPage extends StatefulWidget {
  final int index;
  const MainPage({super.key, this.index = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      Provider.of<NavigatorPageProvider>(context, listen: false).selectedIndex =
          widget.index;
    });

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigatorPageProvider>(builder: (context, prov, child) {
      return Scaffold(
        body: NavigatorPage.pages[prov.selectedIndex],
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
            currentIndex: prov.selectedIndex,
            unselectedLabelStyle:
                Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      height: 2,
                    ),
            onTap: (index) => setState(() => prov.selectedIndex = index),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Ionicons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
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
              const BottomNavigationBarItem(
                icon: Icon(Ionicons.notifications_outline),
                label: 'Notification',
              ),
              const BottomNavigationBarItem(
                  icon: Icon(Ionicons.person_outline), label: 'Account'),
            ],
          ),
        ),
      );
    });
  }
}
