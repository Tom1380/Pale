import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ExercisesPage extends StatefulWidget {
  final Future<Database> futureDB = getDatabasesPath().then((String path) {
    return openDatabase(
      join(
        path,
        'exercises',
      ), // When the database is first created, create a table to store exercises.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        // TODO type shoud not be text, but instead an enum. Possible values should be (I think):
        // Bodyweight reps
        // Weighted reps
        // Bodyweight isometric
        // Weighted isometric
        // They all have sets!
        return db.execute(
          "CREATE TABLE exercises (id INTEGER PRIMARY KEY, name TEXT UNIQUE, type TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  });

  ExercisesPage({Key key}) : super(key: key);
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  Future<List<Exercise>> search(String search) async {
    final Database db = await widget.futureDB;
    List<Map<String, dynamic>> maps = await db.query(
      'exercises',
      columns: ['id', 'name', 'type'],
      //where: 'name = \'Panca piana\'',
      where: 'name LIKE ?',
      whereArgs: ['$search%'],
      limit: 30,
    );
    // .query('SELECT id, name, type FROM exercises WHERE name LIKE \'?%\'');
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
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExercisePage(exercise.name),
                ),
              ),
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewExercisePage(widget.futureDB),
          ),
        ),
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
  NewExercisePage(this.futureDB);
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
