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
    );
  }
}
