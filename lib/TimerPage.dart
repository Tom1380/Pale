import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'CustomWidgets.dart';

class TimerPage extends StatefulWidget {
  TimerPage({Key key}) : super(key: key);
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache ac = AudioCache();

  @override
  void initState() {
    super.initState();
    cacheAudios();
  }

  void cacheAudios() async {
    for (int i = 1; i <= 3; i++) {
      await ac.load('$i.wav');
    }
  }

  @override
  Widget build(BuildContext context) {
    int pressed_times = 0;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cronometro',
      ),
      body: Center(
        child: IconButton(
          iconSize: 70,
          icon: Icon(Icons.timer),
          color: Theme.of(context).accentColor,
          onPressed: () async {
            int i = (pressed_times % 3) + 1;
            ac.play('$i.wav');
            pressed_times++;
          },
        ),
      ),
    );
  }
}
