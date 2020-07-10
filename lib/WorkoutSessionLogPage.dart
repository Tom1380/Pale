import 'package:flutter/material.dart';

class WorkoutSessionLog extends StatefulWidget {
  WorkoutSessionLog({Key key}) : super(key: key);
  @override
  _WorkoutSessionLogState createState() => _WorkoutSessionLogState();
}

class _WorkoutSessionLogState extends State<WorkoutSessionLog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sessioni passate'),
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
        elevation: 7,
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
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1,
                          color: Colors.grey[300],
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
                          'Trap Bar DL 130x5',
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Ieri - 07/07/20 10:47',
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
        left: 8,
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
