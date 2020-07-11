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
        title: Text('Scheda'),
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
          child: Center(
            child: Text('Segnaposto'),
          ),
        ),
      ),
    );
    // return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 8.0),
//      child: Card(
//        child: Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: Center(
//            child: TextFormField(
//              controller: widget.controller,
//              decoration: new InputDecoration(
//                prefixIcon: Icon(
//                  Icons.person_outline,
//                  color: Colors.grey,
//                ),
//                labelText: 'Full name',
//                labelStyle: TextStyle(
//                  fontSize: 15,
//                  color: Colors.blue,
//                ),
//                enabledBorder: const OutlineInputBorder(
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(20),
//                  ),
//                  borderSide: const BorderSide(
//                    color: Colors.white,
//                  ),
//                ),
//                focusedBorder: OutlineInputBorder(
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(10),
//                  ),
//                  borderSide: BorderSide(
//                    color: Colors.blue,
//                  ),
//                ),
//              ),
//            ),
//          ),
//        ),
//      ),
//    );
  }
}
