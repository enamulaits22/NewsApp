import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/navbar_provider/navbar_notifier.dart';
import 'package:news_app/favorite/favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:news_app/home/home_page.dart';
import 'package:news_app/settings/settings_page.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<BottomNavBar> {

PageController pageController = PageController(initialPage: 0);

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    int state = ref.watch(navProvider);
    return Scaffold(
          body: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: _widgetOptions,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
            currentIndex: state,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              ref.read(navProvider.notifier).state = index;
              onPageChange(index);
            },
          ),
        );
  }

 void onPageChange(int index){
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
