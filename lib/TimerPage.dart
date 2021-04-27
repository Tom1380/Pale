import 'package:flutter/material.dart';

import 'CustomWidgets.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cronometro',
      ),
      body: Center(
        child: IconButton(
          iconSize: 70,
          icon: Icon(Icons.timer),
          color: Theme.of(context).accentColor,
          onPressed: () => print('Premuto'),
        ),
      ),
    );
  }
}
