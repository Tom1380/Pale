import 'package:flutter/material.dart';

class WorkoutProgramConfiguration extends StatefulWidget {
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
    );
  }
}

class WorkoutProgramDayPreview extends StatefulWidget {
  TextEditingController controller = new TextEditingController();
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WorkoutProgramDayConfigurator(),
            ),
          );
        },
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
            fontSize: 8,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Giorno A')),
      body: ListView.builder(
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          return SetsPerRepsConfigurator('Panca Piana');
        },
      ),
    );
  }
}

class SetsPerRepsConfigurator extends StatefulWidget {
  String name;
  int sets;
  List<int> reps = [];
  bool constantReps = true;
  SetsPerRepsConfigurator(this.name);
  @override
  _SetsPerRepsConfiguratorState createState() =>
      _SetsPerRepsConfiguratorState();
}

class _SetsPerRepsConfiguratorState extends State<SetsPerRepsConfigurator> {
  Widget setsTextField() {
    return Container(
      width: 100,
      child: TextFormField(
        initialValue: '${widget.sets ?? ''}',
        decoration: new InputDecoration(labelText: "Sets"),
        keyboardType: TextInputType.number,
        onChanged: (input) {
          setState(() {
            widget.sets = int.parse(input);
          });
        },
        cursorColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget repsTextField() {
    return Container(
      width: 100,
      child: TextField(
        decoration: new InputDecoration(labelText: "Reps"),
        keyboardType: TextInputType.number,
        cursorColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget constantSetsVariantSubWidgets() {
    return Row(
      children: [
        setsTextField(),
        Padding(
          padding: EdgeInsets.all(8),
        ),
        repsTextField(),
      ],
    );
  }

  Widget nonConstantSetsVariantSubWidgets() {
    List<Widget> widgets = [
      setsTextField(),
      Padding(
        padding: EdgeInsets.all(8),
      ),
    ];
    for (int i = 0; i < (widget.sets ?? 1); ++i) {
      widgets.add(repsTextField());
    }
    return Column(
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                widget.constantReps
                    ? constantSetsVariantSubWidgets()
                    : nonConstantSetsVariantSubWidgets(),
              ],
            ),
          ],
        ),
      ),
      onDoubleTap: () {
        if (!widget.constantReps) {
          for (int i = 0; i < widget.reps.length; ++i) {
            widget.reps[i] = widget.reps[0];
          }
        }
        setState(() {
          widget.constantReps = !widget.constantReps;
        });
      },
    );
  }
}
