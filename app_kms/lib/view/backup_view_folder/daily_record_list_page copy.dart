import 'dart:convert';

import 'package:app_kms/view/daily_record_page/daily_record_details_page.dart';
import 'package:app_kms/view/model/config.dart';
import 'package:app_kms/view/model/dailyRecordList.dart';
import 'package:app_kms/view/model/projectDetails.dart';
import 'package:app_kms/view/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class DailyRecordPage extends StatefulWidget {
  final User user;
  const DailyRecordPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DailyRecordPage> createState() => _DailyRecordPageState();
}

class _DailyRecordPageState extends State<DailyRecordPage> {
  List<Map<String, dynamic>> _allProject = [];
  List<Map<String, dynamic>> _foundUsers = [];
  var findKey = '';

  Future getAllCategory() async {
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

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllCategory();
    });
  }

  // This function is called whenever the text field changes
  Future<void> _runFilter(String enteredKeyword) async {
    var baseUrl = MyConfig.server + "/daily_record_list.php";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        var streetsFromJson = jsonData['project_data'];
        _allProject = List<Map<String, dynamic>>.from((streetsFromJson));
      });
    }
    Fluttertoast.showToast(
        msg: "Finding Project",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0);
    List<Map<String, dynamic>> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allProject;
    } else {
      print("Find the Project");
      results = _allProject
          .where((user) => user["project_code"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      Fluttertoast.showToast(
          msg: "DR Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      // we use the toLowerCase() method to make it case-insensitive
    }
    findKey = enteredKeyword;
    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Daily Record'),
        actions: [
          IconButton(
              onPressed: _refresh, icon: const Icon(Icons.refresh_rounded)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => setState(() {
                findKey = value;
                _runFilter(value);
              }),
              decoration: const InputDecoration(
                  labelText:
                      'Search Project (Please insert more than 3 caharacter)',
                  suffixIcon: Icon(Icons.search)),
            ),
            Text("Result Found : " + _foundUsers.length.toString()),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => {
                          _getProjectInfo(
                              _foundUsers[index]["daily_record_id"].toString())
                        },
                        child: Card(
                          key: ValueKey(_foundUsers[index]["project_code"]),
                          // color: Colors.amberAccent,
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                                  _foundUsers[index]['record_date'].toString() +
                                  ")\n"),
                              subtitle: Text(_foundUsers[index]["site_activity"]
                                  .toString()),
                              trailing: Text(
                                  _foundUsers[index]['record_by'].toString()),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
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

  _refresh() {
    print("findKey");
    print(findKey);
    _runFilter(findKey);
    // getAllCategory();
  }
}
