import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'ExercisesPage/ExercisesPage.dart';
import 'db.dart';

class WorkoutProgramConfiguration extends StatefulWidget {
  final Future<Database> futureDB = dbConnection();
  WorkoutProgramConfiguration({Key key}) : super(key: key);
  @override
  _WorkoutProgramConfigurationState createState() =>
      _WorkoutProgramConfigurationState();
}

class _WorkoutProgramConfigurationState
    extends State<WorkoutProgramConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('La mia scheda'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return WorkoutProgramDayPreview();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewWorkoutDay(),
          ),
        ),
      ),
    );
  }
}

class WorkoutProgramDayPreview extends StatefulWidget {
  @override
  _WorkoutProgramDayPreviewState createState() =>
      _WorkoutProgramDayPreviewState();
}

class _WorkoutProgramDayPreviewState extends State<WorkoutProgramDayPreview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: GestureDetector(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                      child: Text(
                        'A',
                        style: TextStyle(
                          fontSize: 40,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    WorkoutProgramDayExerciseList([
                      'Trazioni 5 x max',
                      'Panca piana 10-7-5-3',
                      'T-Bar row 10-7-5',
                      'Military press 3 x 10',
                      'Squat 4 x 5',
                      'Curl 4 x 6-8',
                      'French press 4 x 6-8',
                      'Crunch inversi a terra 4 x 15',
                    ]),
                  ],
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WorkoutProgramDayConfigurator(),
          ),
        ),
      ),
    );
  }
}

class WorkoutProgramDayExerciseList extends StatelessWidget {
  final List<String> exerciseList;
  WorkoutProgramDayExerciseList(this.exerciseList);
  Widget rowChild(BuildContext context, List<String> strings) {
    List<Text> texts = [];
    for (int i = 0; i < strings.length; ++i) {
      texts.add(
        Text(
          strings[i],
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontSize: 10,
            color: Colors.blueGrey[600],
          ),
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(
        left: 16,
      ),
      padding: EdgeInsets.only(
        left: 16,
      ),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 1,
            color: Colors.grey[300],
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: texts,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> rowChildren = [];
    if (this.exerciseList.length <= 4) {
      rowChildren.add(
        rowChild(
          context,
          this.exerciseList,
        ),
      );
    } else if (this.exerciseList.length <= 8) {
      rowChildren.add(
        rowChild(
          context,
          this.exerciseList.sublist(0, 4),
        ),
      );
      rowChildren.add(
        rowChild(
          context,
          this.exerciseList.sublist(4, this.exerciseList.length),
        ),
      );
    } else {
      int middle = (this.exerciseList.length / 2).round();
      rowChildren.add(
        rowChild(
          context,
          this.exerciseList.sublist(0, middle),
        ),
      );
      rowChildren.add(
        rowChild(
          context,
          this.exerciseList.sublist(middle, this.exerciseList.length),
        ),
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rowChildren,
    );
  }
}

class WorkoutProgramDayConfigurator extends StatefulWidget {
  @override
  _WorkoutProgramDayConfiguratorState createState() =>
      _WorkoutProgramDayConfiguratorState();
}

class _WorkoutProgramDayConfiguratorState
    extends State<WorkoutProgramDayConfigurator> {
  List<Widget> exercises = [];

  Widget exerciseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              Exercise exercise = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExercisesPage(isPicker: true),
                ),
              );
              if (exercise != null) {
                setState(
                  () => exercises.add(
                    exercise.type == 0
                        ? RepsConfigurator(exercise)
                        : IsometricConfigurator(exercise),
                  ),
                );
              }
            },
            icon: Icon(Icons.add),
            label: Text('Aggiungi esercizio'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> lvChildren = new List.from(exercises);
    lvChildren.add(
      exerciseButton(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Giorno A'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: lvChildren,
        ),
      ),
    );
  }
}

class RepsConfigurator extends StatefulWidget {
  Exercise exercise;
  int sets;
  List<int> reps = [null];
  bool constantReps = true;
  RepsConfigurator(this.exercise);
  @override
  _RepsConfiguratorState createState() => _RepsConfiguratorState();
}

class _RepsConfiguratorState extends State<RepsConfigurator> {
  Widget setsTextField(BuildContext context) {
    return Container(
      width: 100,
      child: TextFormField(
        initialValue: '${widget.sets ?? ''}',
        decoration: new InputDecoration(labelText: "Sets"),
        keyboardType: TextInputType.number,
        onChanged: (input) {
          int value = int.parse(input);
          if (value < 1) {
            return;
          }
          setState(() {
            widget.sets = value;
          });
          if (widget.reps.length != widget.sets) {
            widget.reps = List.filled(widget.sets ?? 1, widget.reps[0]);
          }
        },
        cursorColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget repsTextField(BuildContext context, int index) {
    return Container(
      width: 100,
      child: TextFormField(
        initialValue:
            '${widget.reps[index >= widget.reps.length ? widget.reps.length - 1 : index] ?? ''}',
        decoration: new InputDecoration(labelText: "Reps"),
        keyboardType: TextInputType.number,
        onChanged: (input) {
          setState(() {
            int value = int.parse(input);
            if (value < 1) {
              return;
            }
            if (widget.constantReps) {
              for (int i = 0; i < widget.reps.length; ++i) {
                widget.reps[i] = value;
              }
            } else {
              widget.reps[index] = value;
            }
          });
        },
        cursorColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget constantSetsVariantSubWidgets(BuildContext context) {
    return Row(
      children: [
        setsTextField(context),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        repsTextField(context, 0),
      ],
    );
  }

  Widget nonConstantSetsVariantSubWidgets(BuildContext context) {
    List<Widget> widgets = [
      setsTextField(context),
      Padding(
        padding: EdgeInsets.all(8),
      ),
    ];
    for (int i = 0; i < (widget.sets ?? 1); ++i) {
      widgets.add(repsTextField(context, i));
    }
    return Column(
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    print('sets: ${widget.sets} reps: ${widget.reps}');

    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  widget.exercise.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  'A ripetizioni',
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                widget.constantReps
                    ? constantSetsVariantSubWidgets(context)
                    : nonConstantSetsVariantSubWidgets(context),
              ],
            ),
          ],
        ),
      ),
      onDoubleTap: () {
        widget.reps = List.filled(widget.sets ?? 1, widget.reps[0]);
        setState(() {
          widget.constantReps = !widget.constantReps;
        });
      },
    );
  }
}

class IsometricConfigurator extends StatefulWidget {
  Exercise exercise;
  IsometricConfigurator(this.exercise);
  @override
  _IsometricConfiguratorState createState() => _IsometricConfiguratorState();
}

class _IsometricConfiguratorState extends State<IsometricConfigurator> {
  // TODO build this.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text('TODO'),
    );
  }
}

class NewWorkoutDay extends StatefulWidget {
  @override
  _NewWorkoutDayState createState() => _NewWorkoutDayState();
}

class _NewWorkoutDayState extends State<NewWorkoutDay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuovo giorno',
        ),
      ),
    );
  }
}
