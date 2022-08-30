import 'dart:convert';

import 'package:app_kms/view/model/config.dart';
import 'package:app_kms/view/model/projectDetails.dart';
import 'package:app_kms/view/model/user.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    @override
    void initState() {
      super.initState();
      Future.delayed(Duration.zero, () {
        print("init");
        _findProject();
      });
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

  void _findProject() {
    print("_findProject");

    http.post(Uri.parse(MyConfig.server + "/project_code_find_id.php"),
        body: {"projectid": widget.projectdetails.Project_ID}).then((response) {
      print("response.statusCode");
      print(response.statusCode);

      var jsondata = jsonDecode(response.body);
    });
  }
}
