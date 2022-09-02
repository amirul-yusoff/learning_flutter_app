import 'package:app_kms/view/asset_page/asset_list_page.dart';
import 'package:app_kms/view/daily_record_page/daily_record_page_main.dart';
import 'package:app_kms/view/member_page/member_list_page.dart';
import 'package:app_kms/view/profile_page/profile_page.dart';
import 'package:app_kms/view/project_page/project_page_main.dart';
import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

import 'login_page.dart';
import 'model/user.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
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
        title: const Text('Main Menu'),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserProfilePage(user: widget.user)),
                                  );
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
                                            MemberListPage(user: widget.user)),
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
}
