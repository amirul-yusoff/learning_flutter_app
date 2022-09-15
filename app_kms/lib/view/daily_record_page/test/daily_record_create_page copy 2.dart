import 'dart:convert';

import 'package:app_kms/model/config.dart';
import 'package:app_kms/model/dailyRecordWorkorderform.dart';
import 'package:app_kms/model/user.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:http/http.dart' as http;

class dailyRecordCreatePage extends StatefulWidget {
  final User user;
  const dailyRecordCreatePage({Key? key, required this.user}) : super(key: key);

  @override
  State<dailyRecordCreatePage> createState() => _dailyRecordCreatePageState();
}

class _dailyRecordCreatePageState extends State<dailyRecordCreatePage> {
  List<String> _ProjectCode = <String>[];
  List<String> _Workorder = <String>[];
  List<DailyRecordWorkorderform> workorderForm = [];
  List<Widget> _cardList = [];

  var selectedProjectCode;
  var selectedWorkorder;
  int start = 0;
  void _addCardWidget() {
    setState(() {
      _cardList.add(_card());
    });
  }

  Widget _card() {
    return Container(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            DropdownSearch<String>(
              mode: Mode.DIALOG,
              showSelectedItems: true,
              items: _Workorder,
              dropdownSearchDecoration: const InputDecoration(
                labelText: "Choose Workorder",
                hintText: "Workorder",
              ),
              // onChanged: null,
              selectedItem: selectedWorkorder,
              showSearchBox: true,
              searchFieldProps: const TextFieldProps(
                cursorColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      )),
    );
  }

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addCardWidget,
      ),
      appBar: AppBar(
        title: const Text('Create Daily Record'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSelectedItems: true,
                  items: _ProjectCode,
                  dropdownSearchDecoration: const InputDecoration(
                    labelText: "Choose Project Code",
                    hintText: "Project Code",
                  ),
                  onChanged: itemSelectionChangedgetWorkorder,
                  selectedItem: selectedProjectCode,
                  showSearchBox: true,
                  searchFieldProps: const TextFieldProps(
                    cursorColor: Colors.blue,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  // style: style,
                  onPressed: _addCardWidget,
                  child: const Text('Add Workorder'),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                    padding: EdgeInsets.only(top: 10),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _cardList.length,
                    itemBuilder: (context, index) {
                      return _cardList[index];
                    }),
              ],
            )),
      ),
    );
  }

// ListView.builder(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           itemCount: _cardList.length,
//           itemBuilder: (context, index) {
//             return _cardList[index];
//           }),

  void onAddForm() {
    setState(() {
      start++;
      print(start);
    });
    print("add");
  }

  Future itemSelectionChangedgetWorkorder(String? pcode) async {
    var afterSplit = pcode.toString().split('-');

    setState(() {
      _Workorder = [];
      _Workorder.clear();
      selectedProjectCode = afterSplit[0];
      selectedWorkorder = '';
    });

    http.post(Uri.parse(MyConfig.server + "/find_workorder_by_project.php"),
        body: {
          "projectCode": afterSplit[0].toString(),
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Found Workorder",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          _Workorder.clear();
          selectedWorkorder = null;
          for (var i = 0; i < jsondata['project_data'].length; i++) {
            _Workorder.add(
                jsondata['project_data'][i]['WorkOrderNumber'].toString());
          }
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

  Future getState() async {
    var baseUrl = MyConfig.server + "/project_code_list_selection.php";

    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Updating List"));
    progressDialog.show();
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        _ProjectCode.clear();
        selectedWorkorder = null;
        for (var i = 0; i < jsonData['project_data'].length; i++) {
          _ProjectCode.add(jsonData['project_data'][i]['Project_Code']
                  .toUpperCase() +
              '-' +
              jsonData['project_data'][i]['Project_Short_name'].toUpperCase());
        }
      });
    }
    progressDialog.dismiss();
  }
}
