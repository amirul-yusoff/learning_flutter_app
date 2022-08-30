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
  List<String> _kOptions = <String>[
    'aardvark',
    'bobcat',
    'chameleon',
  ];

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllCategory();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    print(_kOptions);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daily Record By Project'),
        ),
        body: Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            print(textEditingValue.text);
            if (textEditingValue.text == '') {
              return const Iterable<String>.empty();
            }
            return _kOptions.where((String option) {
              return option
                  .toLowerCase()
                  .contains(textEditingValue.text.toLowerCase());
            });
          },
          onSelected: (String selection) {
            debugPrint('You just selected $selection');
          },
        ));
  }

  Future getAllCategory() async {
    print("getAllCategory");

    var baseUrl = MyConfig.server + "/asset_list_pdo.php";

    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        _kOptions = List<String>.from(jsonData['project_data']
            .map((project) => project['device_name'].toString())
            .toList());
        print(_kOptions);
      });

      // print(jsonData['id']);
    }
  }
}
