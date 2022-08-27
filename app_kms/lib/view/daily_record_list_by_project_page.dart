import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/config.dart';
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
  List categoryItemlist = [];

  Future getAllCategory() async {
    var baseUrl = "https://gssskhokhar.com/api/classes/";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemlist = jsonData;
      });
    }
  }

  // Future getAllCategory() async {
  //   var baseUrl = MyConfig.server + "/project_code_list.php";
  //   http.Response response = await http.get(Uri.parse(baseUrl));
  //   print("response.statusCode");
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     var jsonData = json.decode(response.body);
  //     var extractdata = jsonData['project_data'];
  //     print(extractdata);
  //     print(jsonData);
  //     setState(() {
  //       categoryItemlist = extractdata;
  //       print("categoryItemlist");
  //       print(categoryItemlist);
  //     });
  //   }
  //   print(categoryItemlist);
  // }

  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DropDown List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
