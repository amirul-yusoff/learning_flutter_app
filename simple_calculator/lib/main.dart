import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController firsttextEditingController =
      TextEditingController(text: '0');
  TextEditingController secondtextEditingController =
      TextEditingController(text: '0');
  double _firstValue = 0;
  double _secondValue = 0;
  double _resultValue = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('JTKMS Daily Record'),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Simple Calculator',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                // const Text('Please Enter 1st Number'),
                TextField(
                    controller: firsttextEditingController,
                    decoration: InputDecoration(
                        hintText: 'First Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    keyboardType: const TextInputType.numberWithOptions(),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 10,
                ),
                // const Text('Please Enter 2st Number'),
                TextField(
                    controller: secondtextEditingController,
                    decoration: InputDecoration(
                        hintText: 'Second Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    keyboardType: const TextInputType.numberWithOptions(),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () => {_calculate('+')},
                        child: const Text('+')),
                    ElevatedButton(
                        onPressed: () => {_calculate('-')},
                        child: const Text('-')),
                    ElevatedButton(
                        onPressed: () => {_calculate('*')},
                        child: const Text('*')),
                    ElevatedButton(
                        onPressed: () => {_calculate('/')},
                        child: const Text('/')),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Result " + _resultValue.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 40))
              ],
            ),
          ),
        )),
      ),
    );
  }

  void _calculate(String operation) {
    setState(() {
      double _firstValue = double.parse(firsttextEditingController.text);
      double _secondValue = double.parse(secondtextEditingController.text);

      switch (operation) {
        case "+":
          _resultValue = _firstValue + _secondValue;
          break;
        case "-":
          _resultValue = _firstValue - _secondValue;
          break;
        case "*":
          _resultValue = _firstValue * _secondValue;
          break;
        case "/":
          _resultValue = _firstValue / _secondValue;
          break;
      }

      print(_firstValue);
    });
  }
}
