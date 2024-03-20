import 'package:flash_me/screens/explore.dart';
import 'package:flash_me/screens/home.dart';
import 'package:flash_me/screens/library.dart';
import 'package:flutter/material.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({super.key});

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  int _selectedIndex = 0;
  static const List<Widget> screens = <Widget>[
    HomeScreen(),
    ExploreScreen(),
    LibraryScreen()
  ];

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(Icons.explore),
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Icon(Icons.book),
            ),
            label: 'Library',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) => _onItemTapped(index, context),
        selectedIconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.background),
      ),
    );
  }
}
