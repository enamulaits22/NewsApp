import 'package:news_app/cubit/navbar_cubit.dart';
import 'package:news_app/favorite/favorite_page.dart';
import 'package:news_app/settings/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/home/home_page.dart';
import 'package:news_app/settings/settings_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

PageController pageController = PageController(initialPage: 0);

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    FavoritePage(),
    SettingsPage(),
  ];

  @override
  void initState() {
    BlocProvider.of<ThemeCubit>(context).getThemeValueFromSharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, NavbarState>(
      builder: (context, state) {
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
            currentIndex: state.index,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              BlocProvider.of<NavbarCubit>(context).onItemTapped(index);
              onPageChange(index);
            },
          ),
        );
      },
    );
  }

 void onPageChange(int index){
    pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
