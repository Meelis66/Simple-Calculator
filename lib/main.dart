import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:units_converter/units_converter.dart';

void main(){
  runApp(myApp());
}


class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myApp',
      debugShowCheckedModeBanner: false,
      home: Converter(),
    );
  }
}

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  String ?resultMessage;

  @override

  void initState() {

    userInput = 0;
    super.initState();
  }

  final List<String> measures =[
    'Meters',
    'Kilometer',
    'Grams',
    'Kilograms (kg)',
    'Feet',
    'Miles',
    'Pounds (lbs)',
    'ounces'
  ];

  final Map<String,int> measuresMap ={
    'Meters':0,
    'Kilometer':1,
    'Grams':2,
    'Kilograms (kg)':3,
    'Feet':4,
    'Miles':5,
    'Pounds (lbs)':6,
    'ounces':7
  };

  dynamic formulas ={
    '0':[1,0.001,0,0,3.280,0.0006213,0,0],
    '1':[1000,1,0,0,3280.84,0.6213,0,0,],
    '2':[0,0,1,0.0001,0,0,0.00220,0.03],
    '3':[0,0,1000,1,0,0,2.2046,35.274],
    '4':[0.0348,0.00030,0,0,1,0.000189,0,0],
    '5':[1609.34,1.60934,0,0,05280,1,0,0],
    '6':[0,0,453.592,0.4535,0,0,1,16],
    '7':[0,0,28.3495,0.02834,0,0,0.0625,1]
  };



  void converter (double value,String from,String to)
  {

    int? nFrom=measuresMap[from];
    int? nTo=measuresMap[to];
    var multiplier=formulas[nFrom.toString()][nTo];
    var result=value * multiplier;

    if(result==0)
    {
      resultMessage='Cannot Performed This Conversion';
    }
    else
    {
      resultMessage='${userInput.toString()} $_startMeasures are ${result.toString()} $_convertMeasures';
    }
    setState(() {
      resultMessage=resultMessage;
    });

  }

  late double userInput;
  String ? _startMeasures ;
  String ? _convertMeasures;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
          children: [
            Text('Measures', style: TextStyle(
              fontSize: 50,color: Colors.black,fontWeight: FontWeight.w700
            ),),

            Text('Converter', style: TextStyle(
                fontSize: 50,color: Colors.black,fontWeight: FontWeight.w700
              ),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
              child: TextField(
              onChanged: (text){

                var input = double.tryParse(text);
                if(input != null)
                  setState(() {
                    userInput = input;
                  });

              },



                style: TextStyle(
                  fontSize: 22,color: Colors.black
                ),
               decoration: InputDecoration(
                 filled: true,
                 fillColor: Colors.grey[300],
                 hintText: 'Enter Your Value',
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(20),
                 )
               ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text('From', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _startMeasures,
                    isExpanded: true,
                    dropdownColor: Colors.white70,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                    hint: Text('Choose a Unit', style: TextStyle(color: Colors.black,fontSize: 20),),

                    items: measures.map((String value){
                   return DropdownMenuItem(value: value,
                   child: Text(value),);
                  }).toList(),

                    onChanged: (value){
                      setState(() {
                        _startMeasures = value as String;
                      });

                    },
                  ),
                ),
              ),

            ),
            SizedBox(
              height: 10,
            ),
            Text('To', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 40),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _convertMeasures,
                    isExpanded: true,
                    dropdownColor: Colors.white70,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                    hint: Text('Choose a Unit', style: TextStyle(color: Colors.black,fontSize: 20),),

                    items: measures.map((String value){
                      return DropdownMenuItem(value: value,
                        child: Text(value),);
                    }).toList(),

                    onChanged: (value){
                      setState(() {
                        _convertMeasures = value as String;
                      });
                    },
                  ),
                ),
              ),

            ),
            SizedBox(height: 20,),
            FlatButton(
              onPressed: (){
    if(_startMeasures!.isEmpty || _convertMeasures!.isEmpty || userInput==0)
    return;
    else {
      converter(userInput, _startMeasures!, _convertMeasures!);
    }
              },
              child: Container(
                alignment: AlignmentDirectional.center,
                width: 200,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(20),
                ),
              child: Text('Convert', style: TextStyle(
                fontWeight: FontWeight.w700,fontSize: 40,color: Colors.black
              ),),
              ),
            ),
            SizedBox(height: 15,),
            Text((resultMessage==null)?'':resultMessage as String

              , style: TextStyle(
              fontSize: 30,fontWeight: FontWeight.w700
            ),)
            ],
          ),
          ),
        ),
      ),
    );
  }
}
