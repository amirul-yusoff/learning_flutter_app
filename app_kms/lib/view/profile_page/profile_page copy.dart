import 'dart:convert';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_kms/view/model/config.dart';
import 'package:app_kms/view/model/user.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class UserProfilePage extends StatefulWidget {
  final User user;
  const UserProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late double screenHeight, screenWidth, resWidth;
  List<Map<String, dynamic>> _foundUsers = [];
  var pathAsset = "assets/images/camera.png";
  int defaultValue = 0;

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
          Text(widget.user.employeeCode.toString(),
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
                                Text(widget.user.employeeCode.toString()),
                              ]),
                              TableRow(children: [
                                const Text('Employee Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.user.employeeName.toString()),
                              ]),
                              TableRow(children: [
                                const Text('User Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.user.username.toString()),
                              ]),
                              TableRow(children: [
                                const Text('Email',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.user.mbrEmail.toString()),
                              ]),
                              TableRow(children: [
                                const Text('Position',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.user.position.toString()),
                              ]),
                              TableRow(children: [
                                const Text('Department',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(widget.user.department.toString()),
                              ]),
                            ],
                          ),
                        ),
                      ),
                    ),
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
                              for (var i = 1; i <= _foundUsers.length; i++)
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
                    const SizedBox(height: 40),
                    ToggleSwitch(
                      // minWidth: 90.0,
                      // minHeight: 70.0,
                      initialLabelIndex: defaultValue,
                      cornerRadius: 20.0,
                      activeFgColor: Colors.black,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.white,
                      totalSwitches: 2,
                      icons: const [Icons.dark_mode, Icons.light_mode],
                      iconSize: 30.0,
                      activeBgColors: const [
                        [Colors.black45, Colors.black26],
                        [Colors.yellow, Colors.orange]
                      ],
                      animate:
                          false, // with just animate set to true, default curve = Curves.easeIn
                      curve: Curves
                          .bounceInOut, // animate must be set to true when using custom curve
                      onToggle: (index) {
                        // setState(() {
                        //   _changeMode(index);
                        // });
                        _changeMode(index);
                        // print('switched to: $index');
                      },
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

  _changeMode(index) {
    print("change");
    print(index);
    if (index == 0) {
      setState(() {
        ThemeData.dark();
      });
      print("dark");
    } else {
      print("light");
      setState(() {
        ThemeData.light();
      });
    }
  }

  _findAsset() {
    http.post(Uri.parse(MyConfig.server + "/profile_asset.php"), body: {
      "employeeID": widget.user.id.toString(),
    }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Fetching Data ...",
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
    });
  }
}
