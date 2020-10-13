import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> dbConnection() async {
  return getDatabasesPath().then((String path) {
    return openDatabase(
      join(
        path,
        'pale',
      ),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE exercises (id INTEGER PRIMARY KEY, name TEXT UNIQUE, type INTEGER)",
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
