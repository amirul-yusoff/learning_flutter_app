import 'package:app_kms/view/model/user.dart';
import 'package:app_kms/view/project_page/project_page_all_list.dart';
import 'package:app_kms/view/project_page/project_page_by_employee_code.dart';
import 'package:app_kms/view/project_page/project_page_expiration_list.dart';
import 'package:flutter/material.dart';

class ProjectRegistryMainPage extends StatefulWidget {
  final User user;
  const ProjectRegistryMainPage({Key? key, required this.user})
      : super(key: key);

  @override
  State<ProjectRegistryMainPage> createState() =>
      _ProjectRegistryMainPageState();
}

class _ProjectRegistryMainPageState extends State<ProjectRegistryMainPage> {
  @override
  Widget build(BuildContext context) {
    late double screenHeight, screenWidth, resWidth, resHeight;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    int rowcount = 2;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Module'),
      ),
      body: Center(
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
                  // childAspectRatio: ((itemWidth / itemHeight) * 2),
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
                                          ProjectByEmpoyeeCodePage(
                                              user: widget.user)),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: const <Widget>[
                                  SizedBox(height: 40),
                                  Text(
                                    "My Project",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Center(
                                      child: Icon(
                                    Icons.list,
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
                                      builder: (context) => ProjectRegistryPage(
                                          user: widget.user)),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: const <Widget>[
                                  SizedBox(height: 40),
                                  Text(
                                    "All Project List",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Center(
                                      child: Icon(
                                    Icons.list,
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
                                          ProjetExpiredPage(user: widget.user)),
                                );
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: const <Widget>[
                                  SizedBox(height: 40),
                                  Text(
                                    "Project Expired",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Center(
                                      child: Icon(
                                    Icons.list,
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
    );
  }
}
