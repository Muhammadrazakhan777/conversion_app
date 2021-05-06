import 'dart:convert';

import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  double userInput;
  String _startMeasure;
  String _convertMeasure;
  String resultMessage;

  final List<String> measure = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'mile',
    'pounds',
    'ounce',
  ];
  final Map<String, int> measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'mile': 5,
    'pounds': 6,
    'ounce': 7,
  };
  dynamic formulas = {
    '0': [1, 0.001, 0, 0, 3.280, 0.0006213, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0, 6213, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220, 0.03],
    '3': [0, 0, 1000, 1, 0, 0, 2.2046, 35.274],
    '4': [0.0348, 0.00030, 0, 0, 1, 0.000189],
    '5': [1609.34, 1.60934, 0, 05280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.4535, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.02834, 3.28084, 0, 0.1]
  };
  void convert(double value, String from, String to) {
    int nFrom = measuresMap[from];
    int nto = measuresMap[to];
    var multi = formulas[nFrom.toString()][nto];
    var result = value * multi;
    if (result == 0) {
      resultMessage = 'cannot perform conversion';
    } else {
      resultMessage =
          '${userInput.toString()}${_startMeasure.toString()} are ${_convertMeasure.toString()} $result';
    }
    setState(() {
      resultMessage = resultMessage;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Text(
                    'Conversion ',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'App',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.blue,
                        fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: TextField(
                      onChanged: (text) {
                        var input = double.tryParse(text);
                        if (input != null) {
                          setState(() {
                            userInput = input;
                          });
                        }
                      },
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 22,
                      ),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'enter you value',
                          hintStyle: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'From',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _startMeasure,
                            dropdownColor: Colors.black,
                            hint: Text(
                              'select a unit',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue),
                            isExpanded: true,
                            items: measure.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _startMeasure = value;
                              });
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'To',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.blue),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 40),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                            value: _convertMeasure,
                            dropdownColor: Colors.black,
                            hint: Text(
                              'select a unit',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 20,
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue),
                            isExpanded: true,
                            items: measure.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _convertMeasure = value;
                              });
                            }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FlatButton(
                    onPressed: () {
                      if (_startMeasure.isEmpty || _convertMeasure.isEmpty) {
                        return;
                      } else {
                        convert(userInput, _startMeasure, _convertMeasure);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        'Result',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    (resultMessage == null) ? '' : resultMessage,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
