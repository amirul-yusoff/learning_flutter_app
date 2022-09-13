import 'dart:convert';

import 'package:app_kms/view/asset_page/asset_list_page.dart';
import 'package:app_kms/view/daily_record_page/daily_record_page_main.dart';
import 'package:app_kms/view/member_page/member_list_page.dart';
import 'package:app_kms/model/config.dart';
import 'package:app_kms/view/profile_page/profile_page.dart';
import 'package:app_kms/view/project_page/project_page_main.dart';
import 'package:app_kms/view/test_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ndialog/ndialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';
import 'package:app_kms/model/user.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool itAssetMoudule = false;
  bool projectMoudule = false;
  bool dailyRecordMoudule = false;
  bool membersMoudule = false;

  int superadminPermission = 33;
  int profileMoudulePermission = 0;
  int itAssetMoudulePermission = 0;
  int projectMoudulePermission = 0;
  int dailyRecordMoudulePermission = 0;
  int membersMoudulePermission = 0;

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    late double screenHeight, screenWidth, resWidth, resHeight;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    int rowcount = 2;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Main Menu',
          style: Theme.of(context).textTheme.headline6,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Flexible(
                flex: 2,
                child: Image.asset(
                  'assets/images/main_page.png',
                  scale: 1,
                ),
              ),
              Flexible(
                  flex: 8,
                  child: GridView.count(
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: rowcount,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Material(
                            color: Colors.blue[100],
                            elevation: 8,
                            child: InkWell(
                                highlightColor: Colors.yellow.withOpacity(0.3),
                                splashColor: Colors.red.withOpacity(0.5),
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           UserProfilePage(user: widget.user)),
                                  // );
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.scale,
                                          duration: const Duration(seconds: 1),
                                          alignment: Alignment.center,
                                          child: UserProfilePage(
                                              user: widget.user)));
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: const <Widget>[
                                    SizedBox(height: 40),
                                    Text(
                                      "Profile",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Center(
                                        child: Icon(
                                      Icons.person,
                                      size: 80,
                                    )),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      if (itAssetMoudule)
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Material(
                              color: Colors.blue[100],
                              elevation: 8,
                              child: InkWell(
                                  highlightColor:
                                      Colors.yellow.withOpacity(0.3),
                                  splashColor: Colors.red.withOpacity(0.5),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AssetListPage(user: widget.user)),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const <Widget>[
                                      SizedBox(height: 40),
                                      Text(
                                        "IT Asset",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Center(
                                          child: Icon(
                                        Icons.computer,
                                        size: 80,
                                      )),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      if (projectMoudule)
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Material(
                              color: Colors.blue[100],
                              elevation: 8,
                              child: InkWell(
                                  highlightColor:
                                      Colors.yellow.withOpacity(0.3),
                                  splashColor: Colors.red.withOpacity(0.5),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProjectRegistryMainPage(
                                                  user: widget.user)),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const <Widget>[
                                      SizedBox(height: 40),
                                      Text(
                                        "Project",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Center(
                                          child: Icon(
                                        Icons.house,
                                        size: 80,
                                      )),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      if (dailyRecordMoudule)
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Material(
                              color: Colors.blue[100],
                              elevation: 8,
                              child: InkWell(
                                  highlightColor:
                                      Colors.yellow.withOpacity(0.3),
                                  splashColor: Colors.red.withOpacity(0.5),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DailyRecordMainPage(
                                                  user: widget.user)),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const <Widget>[
                                      SizedBox(height: 40),
                                      Text(
                                        "Daily Record",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Center(
                                          child: Icon(
                                        Icons.construction_rounded,
                                        size: 80,
                                      )),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      if (membersMoudule)
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(40),
                            child: Material(
                              color: Colors.blue[100],
                              elevation: 8,
                              child: InkWell(
                                  highlightColor:
                                      Colors.yellow.withOpacity(0.3),
                                  splashColor: Colors.red.withOpacity(0.5),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MemberListPage(
                                              user: widget.user)),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: const <Widget>[
                                      SizedBox(height: 40),
                                      Text(
                                        "Members",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Center(
                                          child: Icon(
                                        Icons.groups_outlined,
                                        size: 80,
                                      )),
                                    ],
                                  )),
                            ),
                          ),
                        ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Material(
                            color: Colors.blue[100],
                            elevation: 8,
                            child: InkWell(
                                highlightColor: Colors.yellow.withOpacity(0.3),
                                splashColor: Colors.red.withOpacity(0.5),
                                onTap: () {
                                  signOut();
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: const <Widget>[
                                    SizedBox(height: 40),
                                    Text(
                                      "Log Out",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Center(
                                        child: Icon(
                                      Icons.power_settings_new_sharp,
                                      size: 80,
                                    )),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Material(
                            color: Colors.blue[100],
                            elevation: 8,
                            child: InkWell(
                                highlightColor: Colors.yellow.withOpacity(0.3),
                                splashColor: Colors.red.withOpacity(0.5),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            TestPathProviderPage(
                                                user: widget.user)),
                                  );
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: const <Widget>[
                                    SizedBox(height: 40),
                                    Text(
                                      "Test Path Provider",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Center(
                                        child: Icon(
                                      Icons.construction_rounded,
                                      size: 80,
                                    )),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  //signout function
  signOut() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."), title: const Text("Log Out"));
    progressDialog.show();
    await Future.delayed(const Duration(seconds: 2));
    progressDialog.dismiss();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  Future _checkPermission() async {
    http.post(Uri.parse(MyConfig.server + "/check_permissions.php"),
        body: {"employeeID": widget.user.id.toString()}).then((response) {
      var jsondata = jsonDecode(response.body);
      if (jsondata['responseCode'] == 200) {
        Fluttertoast.showToast(
            msg: "Checking Permission",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        for (var i = 0; i < jsondata['project_data'].length; i++) {
          if (jsondata['project_data'][i]['role_id'].toString() ==
              superadminPermission.toString()) {
            setState(() {
              itAssetMoudule = true;
              projectMoudule = true;
              dailyRecordMoudule = true;
              membersMoudule = true;
            });
          }
        }
      }
    });
  }
}
