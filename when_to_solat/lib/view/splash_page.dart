import 'dart:async';

import 'package:flutter/material.dart';
import 'package:when_to_solat/view/main_page.dart';

void main() => runApp(const SplashPage());

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
            MaterialPageRoute(builder: (context) => const MainPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage('assets/images/Azan_Main_Page.jpg'),
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  fit: BoxFit.cover)),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "AZAN APPLICATION",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              CircularProgressIndicator(),
              Text(
                "Version 0.1",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
