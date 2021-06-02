import 'dart:async';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

import 'CustomWidgets.dart';

// TODO find a way to leave the timer on when you switch to another tab of the app.

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
        child: TimerWidget(),
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache ac = AudioCache();

  bool started = false;

  @override
  void initState() {
    super.initState();
    cacheAudios();
  }

  void cacheAudios() async {
    for (int i = 0; i < 10; i++) {
      await ac.load('$i.mp3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return started
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MinutesAndSeconds(ac),
              iconButton(),
            ],
          )
        : iconButton();
  }

  Widget iconButton() {
    // TODO Hero only works with different pages, either find a way to do it on the same page or remove it.
    return IconButton(
      padding: const EdgeInsets.all(0.0),
      iconSize: 70,
      icon: Icon(Icons.timer),
      color: Theme.of(context).accentColor,
      onPressed: () {
        setState(() {
          started = !started;
        });
      },
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  AudioCache ac;

  MinutesAndSeconds(this.ac);

  @override
  _MinutesAndSecondsState createState() => _MinutesAndSecondsState();
}

class _MinutesAndSecondsState extends State<MinutesAndSeconds> {
  Timer timer;
  int secondsSinceStart = 0;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      Duration(seconds: 1),
      (Timer t) {
        setState(() => secondsSinceStart++);
        widget.ac.play(
          "${(secondsSinceStart % 10)}.mp3",
          mode: PlayerMode.LOW_LATENCY,
        );
      },
    );
    Wakelock.enable();
  }

  @override
  void dispose() {
    timer?.cancel();
    Wakelock.disable();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      formattedTime(),
      style: TextStyle(fontSize: 50),
    );
  }

  String formattedTime() {
    int seconds = secondsSinceStart % 60;
    int minutes = (secondsSinceStart / 60).floor();
    String minutesString = minutes < 10 ? '0$minutes' : '$minutes';
    String secondsString = seconds < 10 ? '0$seconds' : '$seconds';
    return '$minutesString:$secondsString';
  }
}
