import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'ExercisesPage.dart';

class NewExercisePage extends StatefulWidget {
  final Future<Database> futureDB;
  final bool isPicker;
  int repsOrIsometricChoice;
  NewExercisePage(
    this.futureDB, {
    @required this.isPicker,
  });
  @override
  _NewExercisePageState createState() => _NewExercisePageState();
}

class _NewExercisePageState extends State<NewExercisePage> {
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Widget> columnChildren = [
      TextField(
        controller: myController,
        onChanged: (text) => setState(() {}),
        decoration: InputDecoration(
          hintText: 'Nome',
        ),
        cursorColor: Theme.of(context).primaryColor,
      ),
      Padding(
        padding: EdgeInsets.all(8),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepsOrIsometricButtons(
            'A ripetizioni',
            selected: widget.repsOrIsometricChoice == 0,
            onPressed: () => setState(() => widget.repsOrIsometricChoice = 0),
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          RepsOrIsometricButtons(
            'Isometrico',
            selected: widget.repsOrIsometricChoice == 1,
            onPressed: () => setState(() => widget.repsOrIsometricChoice = 1),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.all(8),
      ),
    ];

    if (myController.text != "" && widget.repsOrIsometricChoice != null) {
      columnChildren.add(
        FloatingActionButton.extended(
          onPressed: () async {
            final Database db = await widget.futureDB;
            int id = await db.insert(
              'exercises',
              Exercise(
                name: myController.text,
                type: widget.repsOrIsometricChoice,
              ).toMap(),
              conflictAlgorithm: ConflictAlgorithm.fail,
            );
            Navigator.pop(context);
            if (widget.isPicker) {
              Navigator.pop(
                context,
                Exercise(
                  id: id,
                  name: myController.text,
                  type: widget.repsOrIsometricChoice,
                ),
              );
            }
          },
          icon: Icon(Icons.add),
          label: Text('Registra esercizio'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuovo esercizio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: columnChildren,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }
}

class RepsOrIsometricButtons extends StatefulWidget {
  String string;
  bool selected;
  void Function() onPressed;
  RepsOrIsometricButtons(
    this.string, {
    @required this.selected,
    @required this.onPressed,
  });
  @override
  _RepsOrIsometricButtonsState createState() => _RepsOrIsometricButtonsState();
}

class _RepsOrIsometricButtonsState extends State<RepsOrIsometricButtons> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      splashColor: Theme.of(context).accentColor,
      color: Colors.white,
      disabledColor: Theme.of(context).accentColor,
      child: Text(
        widget.string,
        style: TextStyle(
          color: widget.selected ? Colors.white : Theme.of(context).accentColor,
        ),
      ),
      onPressed: widget.selected ? null : () => widget.onPressed(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
        side: BorderSide(color: Theme.of(context).accentColor),
      ),
    );
  }
}
