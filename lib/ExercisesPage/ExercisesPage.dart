import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../CustomWidgets.dart';
import 'NewExercisePage.dart';

class ExercisesPage extends StatefulWidget {
  // Is this used as an exercise picker?
  final bool isPicker;
  ExercisesPage({
    Key key,
    @required this.isPicker,
  }) : super(key: key);
  @override
  _ExercisesPageState createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  Future<List<Exercise>> search(String search) async {
    // List<Map<String, dynamic>> maps = await db.query(
    //   'exercises',
    //   columns: ['id', 'name', 'type'],
    //   where: 'name LIKE ?',
    //   whereArgs: ['%$search%'],
    //   limit: 30,
    // );
    http.Response response = await http.get(
      Uri.parse(
        'http://192.168.40.42:8000/exercises/$search',
      ),
    );
    List<dynamic> maps = jsonDecode(
      response.body,
    );
    return List.generate(maps.length, (i) {
      // TODO use actual ID and actual Type (I should probably change it from int to something else).
      return Exercise(
        id: 1,
        name: maps[i]['exercise'],
        type: 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Esercizi',
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
                    exercise.type == 0 ? "A ripetizioni" : "Isometrico",
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              onTap: () {
                if (widget.isPicker) {
                  Navigator.pop(context, exercise);
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
                isPicker: widget.isPicker,
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
  final int type;

  Exercise({this.id, this.name, this.type});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
    };
  }
}

class ExercisePage extends StatelessWidget {
  ExercisePage(this.exerciseName);
  final String exerciseName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: exerciseName,
      ),
    );
  }
}
