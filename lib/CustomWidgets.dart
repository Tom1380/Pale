import 'package:flutter/material.dart';

class CustomAppBar extends PreferredSize {
  CustomAppBar({
    Key key,
    String title,
    Widget leading,
    List<Widget> actions,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(50),
          child: AppBar(
            title: Text(
              title,
            ),
            leading: leading,
            actions: actions,
          ),
        );
}

class CustomBottomNavigationBar extends PreferredSize {
  CustomBottomNavigationBar({
    Key key,
    List<BottomNavigationBarItem> items,
    int currentIndex,
    void Function(int) onTap,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(30),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: items,
            currentIndex: currentIndex,
            onTap: onTap,
          ),
        );
}
