import 'package:flutter/material.dart';
import 'package:km_to_miles/shared/menu_bottom.dart';
import 'package:km_to_miles/shared/menu_drawer.dart';

class ConverterScreen extends StatefulWidget {
  const ConverterScreen({Key? key}) : super(key: key);

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController txtHeight = TextEditingController();
  final TextEditingController txtWeight = TextEditingController();
  final double fontSize = 18;
  FontWeight fontWeight = FontWeight.w600;
  Color color = Colors.black87;
  String valueMessage = '';
  String unitMessage = '';

  String? resultMessage;

  @override
  void initState() {
    userInput = 0;
    super.initState();
  }

  final List<String> measures = [
    'Meters',
    'Kilometer',
    'Grams',
    'Kilograms (kg)',
    'Feet',
    'Miles',
    'Pounds (lbs)',
    'ounces'
  ];

  final Map<String, int> measuresMap = {
    'Meters': 0,
    'Kilometer': 1,
    'Grams': 2,
    'Kilograms (kg)': 3,
    'Feet': 4,
    'Miles': 5,
    'Pounds (lbs)': 6,
    'ounces': 7
  };

  dynamic formulas = {
    '0': [1, 0.001, 0, 0, 3.280, 0.0006213, 0, 0],
    '1': [
      1000,
      1,
      0,
      0,
      3280.84,
      0.6213,
      0,
      0,
    ],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220, 0.03],
    '3': [0, 0, 1000, 1, 0, 0, 2.2046, 35.274],
    '4': [0.0348, 0.00030, 0, 0, 1, 0.000189, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 05280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.4535, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.02834, 0, 0, 0.0625, 1]
  };

  late double userInput;
  String? _startMeasures;
  String? _convertMeasures;

  @override
  Widget build(BuildContext context) {
    valueMessage = 'Please insert value';
    unitMessage = 'Please insert unit of measurement';
    return Scaffold(
      appBar: AppBar(title: const Text('Converter')),
      bottomNavigationBar: const MenuBottom(),
      drawer: const MenuDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: txtHeight,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: valueMessage),
                onChanged: (text) {
                  var input = double.tryParse(text);
                  if (input != null)
                    setState(() {
                      userInput = input;
                    });
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'From',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                child: DropdownButton(
                  value: _startMeasures,
                  isExpanded: true,
                  dropdownColor: Colors.white70,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: fontWeight, color: color),
                  hint: Text(
                    unitMessage,
                    style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: color),
                  ),
                  items: measures.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _startMeasures = value as String;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'To',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Container(
                child: DropdownButton(
                  value: _convertMeasures,
                  isExpanded: true,
                  dropdownColor: Colors.white70,
                  style: TextStyle(
                      fontSize: fontSize, fontWeight: fontWeight, color: color),
                  hint: Text(
                    unitMessage,
                    style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        color: color),
                  ),
                  items: measures.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _convertMeasures = value as String;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (_startMeasures!.isEmpty ||
                    _convertMeasures!.isEmpty ||
                    userInput == 0)
                  return;
                else {
                  converter(userInput, _startMeasures!, _convertMeasures!);
                }
              },
              child: Text(
                'Convert',
                style: TextStyle(fontSize: fontSize),
              ),
            ),
            Text(
              (resultMessage == null) ? '' : resultMessage as String,
              style: TextStyle(fontSize: fontSize),
            )
          ],
        ),
      ),
    );
  }

  void converter(double value, String from, String to) {
    int? nFrom = measuresMap[from];
    int? nTo = measuresMap[to];
    var multiplier = formulas[nFrom.toString()][nTo];
    var result = value * multiplier;

    if (result == 0) {
      resultMessage = 'Cannot Performed This Conversion';
    } else {
      resultMessage =
          '${userInput.toString()} $_startMeasures are ${result.toString()} $_convertMeasures';
    }
    setState(() {
      resultMessage = resultMessage;
    });
  }
}
