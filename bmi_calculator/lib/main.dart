import 'dart:async';
import 'package:flutter/material.dart';
import 'bmicalpage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const BmiCalcPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Amirul Sdn Bhd',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Image.asset('assets/images/Screenshot_2.png', scale: 1),
          const Text(
            'Version 0.1',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
