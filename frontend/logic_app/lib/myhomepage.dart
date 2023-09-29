import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:core';

class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar(
      {Key? key, required this.child, required this.tabs})
      : super(key: key);
  final Widget child;
  final List<ScaffoldWithNavBarTabItem> tabs;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      ScaffoldWithBottomNavBarState();
}

class ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  //int mittelindex = 0;
  List<String> routeStack = [];

  int _locationToTabIndex(String location) {
    final index =
        widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  void _onItemTapped(BuildContext context, int tabIndex) {
    // Only navigate if the tab index has changed
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log App'),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: List.generate(
          widget.tabs.length,
          (index) => BottomNavigationBarItem(
            icon: InkResponse(
              onTap: () => _onItemTapped(context, index),
              child: widget.tabs[index].icon,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            label: widget.tabs[index].label,
          ),
        ),
        //items: widget.tabs,
        currentIndex: _currentIndex,
        onTap: (index) => _onItemTapped(context, index),
        unselectedItemColor: Color.fromARGB(252, 95, 95, 95),
        selectedItemColor: Color.fromARGB(255, 188, 87, 255),
        unselectedLabelStyle: TextStyle(
          color: Color.fromARGB(252, 95, 95, 95),
        ),
        selectedLabelStyle: TextStyle(
          color: Color.fromARGB(255, 188, 87, 255),
        ),
      ),
    );
  }
}
