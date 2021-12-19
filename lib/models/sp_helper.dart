import 'package:shared_preferences/shared_preferences.dart';
import 'calculations.dart';
import 'dart:convert';


class SPCalcResult {
  static late SharedPreferences prefs;

  Future init() async {
    //SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  }

  Future writeSession(Calculations session) async {
    prefs.setString(session.id.toString(), json.encode(session.toJson()));
  }

  List<Calculations> getSessions() {
    List<Calculations> sessions = [];
    Set<String> keys = prefs.getKeys();
    keys.forEach((String key) {
      if (key != 'counter') {
        Calculations session =
            Calculations.fromJson(json.decode(prefs.getString(key) ?? ''));
        sessions.add(session);
      }
    });
    return sessions;
  }

  Future setCounter() async {
    int counter = prefs.getInt('counter') ?? 0;
    counter++;
    await prefs.setInt('counter', counter);
  }

  int getCounter() {
    return prefs.getInt('counter') ?? 0;
  }

  Future deleteSession(int id) async {
    prefs.remove(id.toString());
  }
}
