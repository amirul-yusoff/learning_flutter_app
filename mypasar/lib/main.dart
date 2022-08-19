import 'package:flutter/material.dart';
import 'package:mypasar/view/splash_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        // fontFamily: 'Georgia',
        // textTheme: const TextTheme(
        //   headline6: TextStyle(fontSize: 20.0),
        //   bodyText1: TextStyle(
        //       fontSize: 12.0, fontFamily: 'Hind', color: Colors.red),
        // )
      ),
      darkTheme: ThemeData.dark(),
      title: 'My Pasar',
      home: const Scaffold(
        body: SplashPage(),
      ),
    );
  }
}
