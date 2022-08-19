import 'package:flutter/material.dart';

class TabPage2 extends StatefulWidget {
  const TabPage2({Key? key}) : super(key: key);

  @override
  State<TabPage2> createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const Text("Tab 2"),
      ),
    );
  }
}
