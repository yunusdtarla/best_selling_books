// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:web_scrapingg/page/kitap_yurdu_page.dart';
import 'page/dr_page.dart';
import 'page/idefix_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [
        KitapYurdu(),
        Idefix(),
        Dr(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.book),
          title: ("Kitap Yurdu"),
          activeColorPrimary: CupertinoColors.activeBlue,
          inactiveColorPrimary: CupertinoColors.activeBlue,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.book),
          title: ("İdefix"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.activeGreen,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.book),
          title: ("DR"),
          activeColorPrimary: CupertinoColors.activeOrange,
          inactiveColorPrimary: CupertinoColors.activeOrange,
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style1 // Choose the nav bar style with this property.
        );
  }
}
