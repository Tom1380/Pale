import 'package:flutter/material.dart';

class WorkoutProgramConfiguration extends StatefulWidget {
  WorkoutProgramConfiguration({Key key}) : super(key: key);
  @override
  _WorkoutProgramConfigurationState createState() =>
      _WorkoutProgramConfigurationState();
}

class _WorkoutProgramConfigurationState
    extends State<WorkoutProgramConfiguration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('La mia scheda'),
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return WorkoutProgramDayConfigurator();
        },
      ),
    );
  }
}

class WorkoutProgramDayConfigurator extends StatefulWidget {
  TextEditingController controller = new TextEditingController();

  @override
  _WorkoutProgramDayConfiguratorState createState() =>
      _WorkoutProgramDayConfiguratorState();
}

class _WorkoutProgramDayConfiguratorState
    extends State<WorkoutProgramDayConfigurator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: 16,
                    ),
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
                        Text('Segnaposto'),
                      ],
                    ),
                  )
                ],
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
