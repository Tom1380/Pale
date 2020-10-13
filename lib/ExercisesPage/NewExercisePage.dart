import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'ExercisesPage.dart';

class NewExercisePage extends StatefulWidget {
  final Future<Database> futureDB;
  final bool isPicker;
  NewExercisePage(
    this.futureDB, {
    @required this.isPicker,
  });
  @override
  _NewExercisePageState createState() => _NewExercisePageState();
}

class _NewExercisePageState extends State<NewExercisePage> {
  int repsOrIsometricChoice;
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
            selected: repsOrIsometricChoice == 0,
            onPressed: () => setState(() => repsOrIsometricChoice = 0),
          ),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          RepsOrIsometricButtons(
            'Isometrico',
            selected: repsOrIsometricChoice == 1,
            onPressed: () => setState(() => repsOrIsometricChoice = 1),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.all(8),
      ),
    ];

    if (myController.text != "" && repsOrIsometricChoice != null) {
      columnChildren.add(
        FloatingActionButton.extended(
          onPressed: () async {
            final Database db = await widget.futureDB;
            int id = await db.insert(
              'exercises',
              Exercise(
                name: myController.text,
                type: repsOrIsometricChoice,
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
                  type: repsOrIsometricChoice,
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

class RepsOrIsometricButtons extends StatelessWidget {
  final void Function() onPressed;
  final String string;
  final bool selected;
  RepsOrIsometricButtons(
    this.string, {
    @required this.selected,
    @required this.onPressed,
  });

  Widget build(BuildContext context) {
    return RaisedButton(
      splashColor: Theme.of(context).accentColor,
      color: Colors.white,
      disabledColor: Theme.of(context).accentColor,
      child: Text(
        string,
        style: TextStyle(
          color: selected ? Colors.white : Theme.of(context).accentColor,
        ),
      ),
      onPressed: selected ? null : () => onPressed(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Theme.of(context).accentColor),
      ),
    );
  }
}
