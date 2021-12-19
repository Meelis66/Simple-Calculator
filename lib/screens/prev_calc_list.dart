import 'package:flutter/material.dart';
import '../models/sp_helper.dart';
import '../models/calculations.dart';

class PrevCalcScreen extends StatefulWidget {
  const PrevCalcScreen({Key? key}) : super(key: key);

  @override
  _PrevCalcScreenState createState() => _PrevCalcScreenState();
}

class _PrevCalcScreenState extends State<PrevCalcScreen> {
  List<Calculations> sessions = [];
  //final TextEditingController txtEquation = TextEditingController();
  final SPCalcResult helper = SPCalcResult();

  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Calc History'),
      ),
      body: ListView(children: getContent()),
      
    );
  }

  

  List<Widget> getContent() {
    List<Widget> tiles = [];
    sessions.forEach((session) {
      tiles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
          helper.deleteSession(session.id).then((value) => updateScreen());
        },
        child: ListTile(
          title: Text('${session.calcHistory}'),
          subtitle:
              Text('${session.date} - duration: ${session.calcHistory} min'),
        ),
      ));
    });
    return tiles;
  }

  void updateScreen() {
    sessions = helper.getSessions();
    setState(() {});
  }
}
