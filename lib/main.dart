import 'package:flutter/material.dart';

import 'WorkoutProgramConfigurationPage.dart';
import 'WorkoutSessionLogPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.redAccent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(),
      ),
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  int _index = 0;

  final List<Widget> _pages = <Widget>[
    WorkoutSessionLog(
      key: PageStorageKey('Page1'),
    ),
    WorkoutProgramConfiguration(
      key: PageStorageKey('Page2'),
    )
  ];

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget._pages[widget._index],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
            ),
            title: Text('Sessioni Passate'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.filter_none,
            ),
            title: Text('Nuova sessione'),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: widget._index,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (int index) => setState(() => widget._index = index),
      ),
    );
  }
}
