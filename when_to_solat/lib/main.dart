import 'dart:io';

import 'package:flutter/material.dart';

import 'view/splash_page.dart';

// void main() => runApp(const MyApp());
void main() {
  HttpOverrides.global = PostHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        // brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        // fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 72.0, fontStyle: FontStyle.italic),
          headline6: TextStyle(
              fontSize: 25.0, fontFamily: 'Hind', color: Colors.white),
          bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      // darkTheme: ThemeData.dark(),
      title: 'App KMS',
      home: const Scaffold(
        body: SplashPage(),
      ),
    );
  }
}

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
