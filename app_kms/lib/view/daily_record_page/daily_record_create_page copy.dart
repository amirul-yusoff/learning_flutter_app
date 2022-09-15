import 'package:app_kms/model/projectInfo.dart';
import 'package:app_kms/model/user.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

class DailyRecordCreatePage extends StatefulWidget {
  final User user;
  final ProjectInfo projectInfo;
  const DailyRecordCreatePage(
      {Key? key, required this.user, required this.projectInfo})
      : super(key: key);

  @override
  State<DailyRecordCreatePage> createState() => _DailyRecordCreatePageState();
}

class _DailyRecordCreatePageState extends State<DailyRecordCreatePage> {
  String dateStartselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dateEndselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Create Daily Record ' + widget.projectInfo.projectCode.toString()),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Flexible(
                flex: 2,
                child: Image.asset(
                  'assets/images/main_page.png',
                  scale: 1,
                ),
              ),
              Flexible(
                flex: 8,
                child: Text('asdsad'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
