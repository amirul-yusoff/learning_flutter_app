import 'dart:convert';

import 'package:app_kms/view/member_page/member_details_page.dart';
import 'package:app_kms/model/config.dart';
import 'package:app_kms/model/members.dart';
import 'package:app_kms/model/projectDetails.dart';
import 'package:app_kms/model/user.dart';
import 'package:app_kms/view/project_page/project_page_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class MemberListPage extends StatefulWidget {
  final User user;
  const MemberListPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MemberListPage> createState() => _MemberListPageState();
}

class _MemberListPageState extends State<MemberListPage> {
  List<Map<String, dynamic>> _allProject = [];
  List<Map<String, dynamic>> _foundUsers = [];
  List<String> _kOptions = <String>[
    ' ',
  ];
  var selection = null;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllCategory();
      getAllMemberList(selection);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("build");
    // print(_kOptions);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Member List'),
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
                  findMember(selection);
                  debugPrint('You just selected $selection');
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
                            _getUserInfo(_foundUsers[index]["id"].toString())
                          },
                          child: Card(
                            key: ValueKey(_foundUsers[index]["employee_code"]),
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
                                  _foundUsers[index]["employee_code"]
                                      .toString(),
                                  style: const TextStyle(fontSize: 24),
                                ),
                                title: Text(_foundUsers[index]['employee_name']
                                    .toString()),
                                subtitle: Text(
                                    _foundUsers[index]["email"].toString()),
                                trailing: Text(
                                    _foundUsers[index]['username'].toString()),
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
    var baseUrl = MyConfig.server + "/members_list.php";

    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        _kOptions = List<String>.from(jsonData['project_data']
            .map((project) =>
                project['id'].toString() +
                "-" +
                project['employee_code'].toString() +
                "-" +
                project['employee_name'].toString())
            .toList());
      });
    }
  }

  Future getAllMemberList(selection) async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Fetching Data"));
    progressDialog.show();
    http.post(Uri.parse(MyConfig.server + "/members_list.php"), body: {}).then(
        (response) {
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          var streetsFromJson = jsondata['project_data'];
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
      progressDialog.dismiss();
    });
  }

  Future findMember(selection) async {
    var afterSplit = selection.split('-');
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Fetching Data"));
    progressDialog.show();
    http.post(Uri.parse(MyConfig.server + "/find_members_list.php"), body: {
      "userId": afterSplit[0].toString(),
    }).then((response) {
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          var streetsFromJson = jsondata['project_data'];
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
      progressDialog.dismiss();
    });
  }

  void _getUserInfo(String index) {
    http.post(Uri.parse(MyConfig.server + "/find_members_list.php"),
        body: {"userId": index.toString()}).then((response) {
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Members members = Members.fromJson(jsondata['project_data'][0]);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MemberDetailsPage(user: widget.user, members: members)));
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
    });
  }
}
