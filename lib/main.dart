import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(),
      ),
      home: MyHomePage(title: 'Sessioni'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return WorkoutSessionPreview();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nuova sessione',
        child: Icon(Icons.add),
      ),
    );
  }
}

class WorkoutSessionPreview extends StatefulWidget {
  @override
  _WorkoutSessionPreviewState createState() => _WorkoutSessionPreviewState();
}

class _WorkoutSessionPreviewState extends State<WorkoutSessionPreview> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'A',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WorkoutSessionPreviewHighlightsText('Highlights'),
                        WorkoutSessionPreviewHighlightsText('Bench 80kg x 3'),
                        WorkoutSessionPreviewHighlightsText('Squat 105kg x 5'),
                        WorkoutSessionPreviewHighlightsText(
                            'Trap Bar DL 130x5'),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Yesterday - 07/07/20 10:47',
                  style: TextStyle(
                    color: Colors.blueGrey[600],
                  ),
                ),
              )
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}

class WorkoutSessionPreviewHighlightsText extends StatelessWidget {
  String _string;
  WorkoutSessionPreviewHighlightsText(this._string);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8, //4,
      ),
      child: Text(
        this._string,
        style: TextStyle(
          color: Colors.blueGrey[600],
        ),
      ),
    );
  }
}
