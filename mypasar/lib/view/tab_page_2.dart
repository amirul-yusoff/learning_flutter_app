import 'package:flutter/material.dart';
import 'package:mypasar/model/user.dart';

class TabPage2 extends StatefulWidget {
  final User user;
  const TabPage2({Key? key, required this.user}) : super(key: key);

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
