import 'dart:convert';

import 'package:app_kms/model/projectDetails.dart';
import 'package:app_kms/model/user.dart';
import 'package:app_kms/model/workorder.dart';
import 'package:app_kms/model/config.dart';
import 'package:app_kms/view/project_page/workorder_details_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ProjectDetailsPage extends StatefulWidget {
  final User user;
  final ProjectDetails projectdetails;
  const ProjectDetailsPage(
      {Key? key, required this.user, required this.projectdetails})
      : super(key: key);

  @override
  State<ProjectDetailsPage> createState() => _ProjectDetailsPageState();
}

class _ProjectDetailsPageState extends State<ProjectDetailsPage> {
  late double screenHeight, screenWidth, resWidth;
  List<Map<String, dynamic>> _foundWorkorders = [];
  @override
  void initState() {
    super.initState();
    _findWorkorder();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Project Details For " + widget.projectdetails.Project_Code),
      ),
      body: Card(
        child: ListView(
          children: [
            const SizedBox(
              height: 5,
            ),
            Card(
                child: ListTile(
              leading: const Text("Project Code : "),
              title: Text(widget.projectdetails.Project_Code),
            )),
            Card(
                child: ListTile(
              leading: const Text("Main Con : "),
              title: Text(widget.projectdetails.license_company),
            )),
            Card(
                child: ListTile(
              leading: const Text("Short Name : "),
              title: Text(widget.projectdetails.Project_Short_name),
            )),
            Card(
                child: ListTile(
              leading: const Text("Project Title : "),
              title: Text(widget.projectdetails.Project_Title),
            )),
            Card(
                child: ListTile(
              leading: const Text("Contract No : "),
              title: Text(widget.projectdetails.Project_Contract_No),
            )),
            Card(
                child: ListTile(
              leading: const Text("PO No : "),
              title: Text(widget.projectdetails.po_no),
            )),
            Card(
                child: ListTile(
              leading: const Text("Contract Original Sum : "),
              title: Text("RM " +
                  double.parse(widget.projectdetails.contract_original_value)
                      .toStringAsFixed(2)),
            )),
            Card(
                child: ListTile(
              leading: const Text("PO Value : "),
              title: Text(widget.projectdetails.po_value),
            )),
            Card(
                child: ListTile(
              leading: const Text("Contract VO Value : "),
              title: Text(widget.projectdetails.contract_vo_value),
            )),
            Card(
                child: ListTile(
              leading: const Text("Contract Start Date : "),
              title: Text(widget.projectdetails.Tarikh_Pesanan),
            )),
            Card(
                child: ListTile(
              leading: const Text("Commencement Date : "),
              title: Text(widget.projectdetails.Project_Commencement_Date),
            )),
            Card(
                child: ListTile(
              leading: const Text("Contract Close Date : "),
              title: Text(widget.projectdetails.Project_Close_Date),
            )),
            Card(
                child: ListTile(
              leading: const Text("Project Team : "),
              title: Text(widget.projectdetails.project_team),
            )),
            Card(
                child: ListTile(
              leading: const Text("Project Team : "),
              title: Text(widget.projectdetails.project_team),
            )),
            for (var i = 1; i <= _foundWorkorders.length; i++)
              Center(
                child: Card(
                  child: ListTile(
                    leading: Text('Workorder $i'),
                    title: Text(
                        _foundWorkorders[i - 1]["WorkOrderNumber"].toString()),
                    subtitle: Text(_foundWorkorders[i - 1]["Status"] +
                        '\n' +
                        _foundWorkorders[i - 1]["DescriptionofWork"]
                            .toString()),
                    trailing: Column(children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _getWorkorderInfo(
                                _foundWorkorders[i - 1]["WorkOrderNumber"]);
                            // _passwordVisible = !_passwordVisible;
                          });
                        },
                        child: const Text(
                          'Check\nDR\nQty',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ]),
                    isThreeLine: true,
                  ),
                ),
              ),
            const SizedBox(
              height: 80,
            ),
          ],
          shrinkWrap: true,
          // reverse: true,
          // padding: EdgeInsets.all(5),
          // itemExtent: 100,
        ),
      ),
    );
  }

  _findWorkorder() {
    http.post(
        Uri.parse(MyConfig.server + "/project_code_find_workorder_by_code.php"),
        body: {
          "prjectcode": widget.projectdetails.Project_Code
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Fetching Workorder Record",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          var streetsFromJson = jsondata['project_data'];
          _foundWorkorders = List<Map<String, dynamic>>.from((streetsFromJson));
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

  _getWorkorderInfo(String workorder) {
    http.post(
        Uri.parse(
            MyConfig.server + "/project_code_find_workorder_by_wokorder.php"),
        body: {"workorder": workorder}).then((response) {
      var jsondata = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Workorders workorders =
            Workorders.fromJson(jsondata['project_data'][0]);
        Fluttertoast.showToast(
            msg: "Fetching Data ...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => WorkorderDetailsPage(
                      user: widget.user,
                      workorders: workorders,
                    )));
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
