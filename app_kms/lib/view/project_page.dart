import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'model/config.dart';
import 'model/user.dart';

class ProjectRegistryPage extends StatefulWidget {
  final User user;
  const ProjectRegistryPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProjectRegistryPage> createState() => _ProjectRegistryPageState();
}

class _ProjectRegistryPageState extends State<ProjectRegistryPage> {
  List<Map<String, dynamic>> _allProject = [];
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _foundUsers = [];

  Future getAllCategory() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Fetching Data"));
    progressDialog.show();
    var baseUrl = MyConfig.server + "/project_code_list.php";

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
    var baseUrl = MyConfig.server + "/project_code_list.php";

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

    if (enteredKeyword.isEmpty || enteredKeyword.length <= 3) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allProject;
    } else {
      results = _allProject
          .where((user) => user["Project_Code"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      Fluttertoast.showToast(
          msg: "Project Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText:
                      'Search Project (Please insert more than 3 caharacter)',
                  suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => {_getProjectInfo(index)},
                        child: Card(
                          key: ValueKey(_foundUsers[index]["Project_Code"]),
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
                                _foundUsers[index]["Project_Code"].toString(),
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: Text(_foundUsers[index]
                                      ['Project_Short_name']
                                  .toString()),
                              subtitle: Text(_foundUsers[index]["Project_Title"]
                                  .toString()),
                              trailing: Text(_foundUsers[index]
                                      ['Project_Status']
                                  .toString()),
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

  void _getProjectInfo(int index) {
    print("getProjectInfo");
    var ProjectID = _foundUsers[index]['Project_ID'];
    print(ProjectID);
  }
}
