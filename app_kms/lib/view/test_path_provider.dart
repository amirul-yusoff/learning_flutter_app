import 'package:app_kms/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class TestPathProviderPage extends StatefulWidget {
  final User user;
  const TestPathProviderPage({Key? key, required this.user}) : super(key: key);

  @override
  State<TestPathProviderPage> createState() => _TestPathProviderPageState();
}

class _TestPathProviderPageState extends State<TestPathProviderPage> {
  String tempPath = "";
  String appDocPath = "";
  getPaths() async {
    Directory tempDir = await getTemporaryDirectory();
    tempPath = tempDir.path;
    print(tempPath);
    //output: /data/user/0/com.example.test/cache

    Directory appDocDir = await getApplicationDocumentsDirectory();
    appDocPath = appDocDir.path;
    print(appDocPath);
    //output: /data/user/0/com.example.test/app_flutter

    setState(() {});
  }

  @override
  void initState() {
    getPaths();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Test Path Provider',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(top: 80),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text("Temp Path: $tempPath"),
                Text("App Path: $appDocPath")
              ],
            )));
  }
}
