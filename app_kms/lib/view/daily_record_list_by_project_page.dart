import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'model/assetList.dart';
import 'model/config.dart';
import 'model/user.dart';
import 'package:http/http.dart' as http;

class DailyRecordByProjectPage extends StatefulWidget {
  final User user;
  const DailyRecordByProjectPage({Key? key, required this.user})
      : super(key: key);

  @override
  State<DailyRecordByProjectPage> createState() =>
      _DailyRecordByProjectPageState();
}

class _DailyRecordByProjectPageState extends State<DailyRecordByProjectPage> {
  TextEditingController _controller = TextEditingController();
  List assetlist = [];
  String titlecenter = "Loading Asset List...";
  List<String> items = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "American Samoa",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antarctica",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Record By Project'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            FlutterDropdownSearch(
              textController: _controller,
              items: items,
              dropdownHeight: 300,
            )
          ],
        ),
      ),
    );
  }
}
