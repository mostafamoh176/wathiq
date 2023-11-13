// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:theka_task/core/util/custom_color.dart';
import 'package:theka_task/features/cart/presentation/view/cart_screen.dart';
import 'package:theka_task/features/favorites/presentation/view/favorite_screen.dart';
import 'package:theka_task/features/home_feature/presentation/view/home_screen.dart';
import 'package:theka_task/features/settings/presentation/view/settings_screen.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
  Widget _currentScreen = const HomeScreen();

  // ignore: non_constant_identifier_names
  get CurrentScreen => _currentScreen;
  int _navIndex = 0;

  set setNavIndex(int value) => _navIndex = value;
  get getNavIndex => _navIndex;
  onSelected(int index) {
    setState(() {});
    _navIndex = index;
    switch (index) {
      case 0:
        _currentScreen = const HomeScreen();
        break;
      case 1:
        _currentScreen = const FavoriteScreen();
        break;
      case 2:
        _currentScreen = const CartScreen();
        break;
      case 3:
        // resetMessagesNotReed();
        _currentScreen = SettingsScreen();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: CurrentScreen,
      bottomNavigationBar: _bottomNavigationBar(context),
      resizeToAvoidBottomInset: true,
    );
  }

  _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      elevation: 5,
      enableFeedback: true,
      selectedIconTheme:
          IconThemeData(color: ColorsManager.primary, size: 25.w),
      unselectedItemColor: ColorsManager.darkGrey,
      backgroundColor: const Color(0xffF7F7F9),
      currentIndex: getNavIndex,
      onTap: (index) => onSelected(index),
      selectedItemColor: ColorsManager.primary,
      unselectedIconTheme:
          IconThemeData(color: ColorsManager.darkGrey, size: 20.w),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          label: "Favorites",
          icon: FaIcon(FontAwesomeIcons.bell),
        ),
        BottomNavigationBarItem(
            label: "Cart", icon: FaIcon(FontAwesomeIcons.cartShopping)),
        BottomNavigationBarItem(
          icon: FaIcon(FontAwesomeIcons.gear),
          label: "Settings",
        ),
      ],
    );
  }
}
