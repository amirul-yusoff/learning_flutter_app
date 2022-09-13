import 'dart:convert';

import 'package:app_kms/view/daily_record_page/daily_record_details_page.dart';
import 'package:app_kms/model/config.dart';
import 'package:app_kms/model/dailyRecordList.dart';
import 'package:app_kms/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class DailyRecordByProjectPage extends StatefulWidget {
  final User user;
  const DailyRecordByProjectPage({Key? key, required this.user})
      : super(key: key);

  @override
  State<DailyRecordByProjectPage> createState() =>
      _DailyRecordByProjectPageState();
}

class _DailyRecordByProjectPageState extends State<DailyRecordByProjectPage> {
  List<Map<String, dynamic>> _allProject = [];
  List<Map<String, dynamic>> _foundUsers = [];
  List<String> _kOptions = <String>[
    'T3308',
  ];

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllCategory();
      getAllDailyRecord();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("build");
    // print(_kOptions);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daily Record By Project'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  // print(textEditingValue.text);
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
                  _getProjectCode(selection);
                  // debugPrint('You just selected $selection');
                },
              ),
              Text("Result Found : " + _foundUsers.length.toString()),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => {
                            _getProjectInfo(_foundUsers[index]
                                    ["daily_record_id"]
                                .toString())
                          },
                          child: Card(
                            key: ValueKey(_foundUsers[index]["project_code"]),
                            // color: Colors.amberAccent,
                            elevation: 4,
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            // margin: const EdgeInsets.symmetric(vertical: 10),
                            child: SizedBox(
                              // width: 300,
                              // height: 100,
                              child: ListTile(
                                leading: Text(
                                  _foundUsers[index]["project_code"].toString(),
                                  style: const TextStyle(fontSize: 24),
                                ),
                                title: Text("Serial No : " +
                                    _foundUsers[index]['serial_no'].toString() +
                                    "\n(" +
                                    _foundUsers[index]['record_date']
                                        .toString() +
                                    ")\n"),
                                subtitle: Text(_foundUsers[index]
                                        ["site_activity"]
                                    .toString()),
                                trailing: Text(
                                    _foundUsers[index]['record_by'].toString()),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Text(
                        'No Data Found',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ],
          ),
        ));
  }

  Future getAllCategory() async {
    var baseUrl = MyConfig.server + "/project_code_list.php";

    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        _kOptions = List<String>.from(jsonData['project_data']
            .map((project) =>
                project['Project_Code'].toString() +
                "-" +
                project['Project_Short_name'].toString())
            .toList());
      });
    }
  }

  Future getAllDailyRecord() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Fetching Data"));
    progressDialog.show();
    var baseUrl = MyConfig.server + "/daily_record_list.php";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        var streetsFromJson = jsonData['project_data'];
        _foundUsers = List<Map<String, dynamic>>.from((streetsFromJson));
      });
    }
    progressDialog.dismiss();
  }

  _getProjectCode(String projectCode) {
    var afterSplit = projectCode.split('-');
    http.post(
        Uri.parse(MyConfig.server + "/find_daily_record_list_by_project.php"),
        body: {
          "projectCode": afterSplit[0].toString(),
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          var streetsFromJson = jsondata['project_data'];
          print(streetsFromJson);
          _foundUsers = List<Map<String, dynamic>>.from((streetsFromJson));
        });
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
    });
  }

  void _getProjectInfo(String dailyRecordID) {
    print(dailyRecordID);

    http.post(Uri.parse(MyConfig.server + "/daily_record_details.php"),
        body: {"dailyRecordID": dailyRecordID}).then((response) {
      print(response.statusCode);

      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var streetsFromJson = jsondata['project_data'][0];
        DailyRecordList dailyRecordList =
            DailyRecordList.fromJson(streetsFromJson);
        Fluttertoast.showToast(
            msg: "Fetching....",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DailyRecordDetails(
                    user: widget.user, dailyRecordList: dailyRecordList)));
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
    });
  }
}
