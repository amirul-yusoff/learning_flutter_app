import 'package:flutter/material.dart';

class TabPage1 extends StatefulWidget {
  const TabPage1({Key? key}) : super(key: key);

  @override
  State<TabPage1> createState() => _TabPage1State();
}

class _TabPage1State extends State<TabPage1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text("Tab 1"),
      ),
    );
  }
}
