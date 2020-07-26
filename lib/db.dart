import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> DBConnection() async {
  return getDatabasesPath().then((String path) {
    return openDatabase(
      join(
        path,
        'pale',
      ),
      onCreate: (db, version) async {
        // TODO type shoud not be text, but instead an enum. Possible values should be (I think):
        // Bodyweight reps
        // Weighted reps
        // Bodyweight isometric
        // Weighted isometric
        // They all have sets!
        await db.execute(
          "CREATE TABLE exercises (id INTEGER PRIMARY KEY, name TEXT UNIQUE, type TEXT)",
        );
        await db.execute(
          "CREATE TABLE workout_program_days (id INTEGER PRIMARY KEY, name TEXT UNIQUE)",
        );
        await db.execute(
          "CREATE TABLE exercises_with (id INTEGER PRIMARY KEY, name TEXT UNIQUE)",
        );
      },
// Set the version. This executes the onCreate function and provides a
// path to perform database upgrades and downgrades.
      version: 1,
    );
  });
}
