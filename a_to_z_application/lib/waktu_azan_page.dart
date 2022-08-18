import 'package:flutter/material.dart';

class WaktuAzanPage extends StatefulWidget {
  const WaktuAzanPage({Key? key}) : super(key: key);

  @override
  State<WaktuAzanPage> createState() => _WaktuAzanPageState();
}

class _WaktuAzanPageState extends State<WaktuAzanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Waktu Azan"),
      ),
      body: Container(
        height: 100,
        width: 100,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/amirul_mobile.png"),
              fit: BoxFit.cover),
        ),
        child: const Text(
          'Image in fullscreen',
          style: TextStyle(fontSize: 34, color: Colors.red),
        ),
      ),
    );
  }
}
