import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'db.dart';

class ExercisesPage extends StatefulWidget {
  // <If you want to remove or edit this comment, remember that a comment in the NewExercisePage widget points to this.>
  // If this is not null, this is a sub-page.
  // So we want to execute this closure after choosing an exercise, because this page is serving as an exercise picker.
  // Creating a new exercise automatically chooses it, hence why we pass it to the NewExercisePage widget.
  // After an exercise is selected, we go back to this page's parent by popping the Navigator enough times.
  void Function(String) onChosen;
  final Future<Database> futureDB = DBConnection();

  ExercisesPage({
    Key key,
    this.onChosen,
  }) : super(key: key);
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  Future<List<Exercise>> search(String search) async {
    final Database db = await widget.futureDB;
    List<Map<String, dynamic>> maps = await db.query(
      'exercises',
      columns: ['id', 'name', 'type'],
      where: 'name LIKE ?',
      whereArgs: ['%$search%'],
      limit: 30,
    );
    return List.generate(maps.length, (i) {
      return Exercise(
        id: maps[i]['id'],
        name: maps[i]['name'],
        type: maps[i]['type'],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esercizi'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SearchBar(
          minimumChars: 0,
          onSearch: search,
          onItemFound: (Exercise exercise, int index) {
            return GestureDetector(
              child: Card(
                child: ListTile(
                  title: Text(exercise.name),
                  subtitle: Text(
                    exercise.type,
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              onTap: () {
                if (widget.onChosen != null) {
                  widget.onChosen(exercise.name);
                  Navigator.pop(context);
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExercisePage(exercise.name),
                  ),
                );
              },
            );
          },
          emptyWidget: Center(
            child: Text(
              'Inizia a digitare per cercare un esercizio.',
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
          searchBarStyle: SearchBarStyle(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewExercisePage(
                widget.futureDB,
                onChosen: widget.onChosen,
              ),
            ),
          );
        },
      ),
    );
  }
}

class Exercise {
  final int id;
  final String name;
  final String type;

  Exercise({this.id, this.name, this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}

class NewExercisePage extends StatefulWidget {
  Future<Database> futureDB;
  // Refer to the comment left on this same variable on the ExercisesPage widget.
  void Function(String) onChosen;
  NewExercisePage(this.futureDB, {this.onChosen});
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
                if (widget.onChosen != null) {
                  widget.onChosen(myController.text);
                  Navigator.pop(context);
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

class ExercisePage extends StatelessWidget {
  ExercisePage(this.exerciseName);
  final String exerciseName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
      ),
    );
  }
}
