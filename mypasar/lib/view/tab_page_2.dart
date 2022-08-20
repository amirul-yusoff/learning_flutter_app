import 'package:flutter/material.dart';
import 'package:mypasar/model/user.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class TabPage2 extends StatefulWidget {
  final User user;
  const TabPage2({Key? key, required this.user}) : super(key: key);

  @override
  State<TabPage2> createState() => _TabPage2State();
}

class _TabPage2State extends State<TabPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.add),
                label: "New Product",
                labelStyle: const TextStyle(color: Colors.black),
                labelBackgroundColor: Colors.green,
                onTap: null),
          ],
        ));
  }
}
