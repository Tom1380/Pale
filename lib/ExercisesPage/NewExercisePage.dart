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
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuovo esercizio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: myController,
              decoration: InputDecoration(
                hintText: 'Nome',
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            FloatingActionButton.extended(
              onPressed: () async {
                final Database db = await widget.futureDB;
                await db.insert(
                  'exercises',
                  Exercise(
                    name: myController.text,
                    type: 'Ripetizioni con peso',
                  ).toMap(),
                  conflictAlgorithm: ConflictAlgorithm.fail,
                );
                Navigator.pop(context);
                if (widget.isPicker) {
                  Navigator.pop(context, myController.text);
                }
              },
              icon: Icon(Icons.add),
              label: Text('Registra esercizio'),
            ),
          ],
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
