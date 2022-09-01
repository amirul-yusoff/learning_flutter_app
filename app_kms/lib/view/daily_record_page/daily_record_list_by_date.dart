import 'dart:convert';

import 'package:app_kms/view/model/config.dart';
import 'package:app_kms/view/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';

class DailyRecordByDate extends StatefulWidget {
  final User user;
  const DailyRecordByDate({Key? key, required this.user}) : super(key: key);

  @override
  State<DailyRecordByDate> createState() => _DailyRecordByDateState();
}

class _DailyRecordByDateState extends State<DailyRecordByDate> {
  List<Map<String, dynamic>> _allProject = [];
  List<Map<String, dynamic>> _foundUsers = [];
  List<String> _kOptions = <String>[
    'T3308',
  ];
  String dateStartselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dateEndselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final format = DateFormat("yyyy-MM-dd");

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllCategory();
      getAllDailyRecordByDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Daily Record By Project'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              DateTimeFormField(
                dateFormat: format,
                initialValue: DateTime.now(),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Select Start Date Daily Record Date',
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                onDateSelected: (DateTime date) {
                  setState(() {
                    String stringdate = date.toString();
                    dateStartselected =
                        stringdate.replaceAll(RegExp(r' 00:00:00.000'), '');
                    dateStartselected = dateStartselected;
                  });
                },
              ),
              const SizedBox(height: 15),
              DateTimeFormField(
                dateFormat: format,
                initialValue: DateTime.now(),
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Colors.black45),
                  errorStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.event_note),
                  labelText: 'Select End Date Daily Record Date',
                ),
                mode: DateTimeFieldPickerMode.date,
                autovalidateMode: AutovalidateMode.always,
                onDateSelected: (DateTime date) {
                  setState(() {
                    String stringdate = date.toString();
                    dateEndselected =
                        stringdate.replaceAll(RegExp(r' 00:00:00.000'), '');
                    dateEndselected = dateEndselected;
                  });
                },
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: _checkDailyRecord,
                  child: const Text("Check Daily Record")),
              Text("Result Found : " + _foundUsers.length.toString()),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                        itemCount: _foundUsers.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => {_getProjectInfo(index)},
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
                                  (index + 1).toString() +
                                      ")" +
                                      _foundUsers[index]["project_code"]
                                          .toString(),
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

  Future getAllDailyRecordByDate() async {
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

  Future<void> _checkDailyRecord() async {
    print("dateStartselected");
    print(dateStartselected);
    print("dateEndselected");
    print(dateEndselected);
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Fetching Data"));
    progressDialog.show();
    http.post(
        Uri.parse(MyConfig.server + "/find_daily_record_list_by_date.php"),
        body: {
          "startDate": dateStartselected,
          "endDate": dateEndselected
        }).then((response) {
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          var streetsFromJson = jsondata['project_data'];
          _foundUsers = List<Map<String, dynamic>>.from((streetsFromJson));
        });
      }
      progressDialog.dismiss();
    });
  }

  void _getProjectInfo(int index) {}
}
