import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExercisesPage extends StatefulWidget {
  final Future<Database> database = getDatabasesPath().then((String path) {
    return openDatabase(
      join(
        path,
        'exercises',
      ), // When the database is first created, create a table to store exercises.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE exercises (id INTEGER PRIMARY KEY, name TEXT UNIQUE, description TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  });

  ExercisesPage({Key key}) : super(key: key);
  SearchBarController controller;
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esercizi'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SearchBar(
          minimumChars: 0,
          onSearch: search,
          onItemFound: (Exercise exercise, int index) {
            return Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.grey[300],
                  ),
                ),
              ),
              child: ListTile(
                title: Text(exercise.name),
                subtitle: Text(
                  exercise.type,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            );
          },
          searchBarStyle: SearchBarStyle(
            borderRadius: BorderRadius.circular(10),
          ),
          searchBarController: widget.controller,
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
              builder: (context) => NewExercisePage(),
            ),
          );
        },
      ),
    );
  }
}

Future<List<Exercise>> search(String search) async {
  return List.generate(5, (int index) {
    return Exercise(
      "Panca Piana",
      "A ripetizioni zavorrato",
    );
  });
}

class Exercise {
  final String name;
  final String type;

  Exercise(this.name, this.type);
}

class NewExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nuovo esercizio'),
      ),
    );
  }
}
