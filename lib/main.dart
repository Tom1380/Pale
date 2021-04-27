import 'package:flutter/material.dart';

import 'CustomWidgets.dart';
import 'ExercisesPage/ExercisesPage.dart';
import 'TimerPage.dart';
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
      title: 'Palestra',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.blue[600],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(color: Colors.blue[900]),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue[900],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
        ),
        cardTheme: CardTheme(
          elevation: 7,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 7),
      ),
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  final List<Widget> _pages = <Widget>[
    WorkoutSessionLog(
      key: PageStorageKey('Page1'),
    ),
    WorkoutProgramConfiguration(
      key: PageStorageKey('Page2'),
    ),
    ExercisesPage(
      key: PageStorageKey('Page3'),
      isPicker: false,
    ),
    TimerPage(
      key: PageStorageKey('Page4'),
    ),
  ];

  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: widget._pages[_index],
        bucket: widget._bucket,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
            ),
            label: 'Sessioni Passate',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.filter_none,
            ),
            label: 'Scheda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_run,
            ),
            label: 'Esercizi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Cronometro',
          ),
        ],
        currentIndex: _index,
        onTap: (int index) => setState(() => _index = index),
      ),
    );
  }
}
