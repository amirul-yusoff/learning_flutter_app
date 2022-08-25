import 'package:flutter/material.dart';

import 'model/user.dart';

class DailyRecordByProjectPage extends StatefulWidget {
  final User user;
  const DailyRecordByProjectPage({Key? key, required this.user})
      : super(key: key);

  @override
  State<DailyRecordByProjectPage> createState() =>
      _DailyRecordByProjectPageState();
}

class _DailyRecordByProjectPageState extends State<DailyRecordByProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Record By Project'),
      ),
    );
  }
}
