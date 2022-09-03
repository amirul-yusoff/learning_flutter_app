import 'dart:convert';

import 'package:app_kms/view/model/config.dart';
import 'package:app_kms/view/model/members.dart';
import 'package:app_kms/view/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class MemberDetailsPage extends StatefulWidget {
  final User user;
  final Members members;
  const MemberDetailsPage({Key? key, required this.user, required this.members})
      : super(key: key);

  @override
  State<MemberDetailsPage> createState() => _MemberDetailsPageState();
}

class _MemberDetailsPageState extends State<MemberDetailsPage> {
  late double screenHeight, screenWidth, resWidth;
  List<Map<String, dynamic>> _foundUsers = [];
  var pathAsset = "assets/images/camera.png";

  @override
  void initState() {
    super.initState();
    _findAsset();
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
        title: const Text('Profile Detail'),
      ),
      body: Column(
        children: [
          //flex
          Flexible(
              flex: 4,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: CachedNetworkImage(
                    width: screenWidth,
                    fit: BoxFit.cover,
                    imageUrl: MyConfig.server + "/images/users/images.png",
                    placeholder: (context, url) =>
                        const LinearProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ))),
          Text(widget.members.employeeCode.toString(),
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Card(
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Table(
                            columnWidths: const {
                              0: FractionColumnWidth(0.3),
                              1: FractionColumnWidth(0.7)
                            },
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.top,
                            children: [
                              TableRow(children: [
                                const Text('Employe Code',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.members.employeeCode.toString()),
                              ]),
                              TableRow(children: [
                                const Text('Employee Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.members.employeeName.toString()),
                              ]),
                              TableRow(children: [
                                const Text('User Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.members.username.toString()),
                              ]),
                              TableRow(children: [
                                const Text('Email',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.members.mbrEmail.toString()),
                              ]),
                              TableRow(children: [
                                const Text('Position',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.members.position.toString()),
                              ]),
                              TableRow(children: [
                                const Text('Department',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.members.department.toString()),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: _foundUsers.isEmpty
                          ? const Text(
                              'No Asset Found',
                              style: TextStyle(fontSize: 24),
                            )
                          : Card(
                              elevation: 10,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  child: Table(
                                    columnWidths: const {
                                      0: FractionColumnWidth(0.3),
                                      1: FractionColumnWidth(0.7)
                                    },
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.top,
                                    children: [
                                      for (var i = 1;
                                          i <= _foundUsers.length;
                                          i++)
                                        TableRow(children: [
                                          Text('IT Asset $i',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          Text(_foundUsers[i - 1]["device_name"]
                                              .toString()),
                                        ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _findAsset() {
    http.post(Uri.parse(MyConfig.server + "/profile_asset.php"), body: {
      "employeeID": widget.members.id.toString(),
    }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Checking Asset ...",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          var streetsFromJson = jsondata['project_data'];
          _foundUsers = List<Map<String, dynamic>>.from((streetsFromJson));
          if (_foundUsers.length == 0) {}
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
}
