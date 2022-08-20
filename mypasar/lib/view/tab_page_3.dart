import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mypasar/model/user.dart';

import 'login_page.dart';
import 'registration_page.dart';

class TabPage3 extends StatefulWidget {
  final User user;
  const TabPage3({Key? key, required this.user}) : super(key: key);

  @override
  _TabPage3State createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> {
  late double screenHeight, screenWidth, resWidth;
  File? _image;
  var pathAsset = "assets/images/profile.png";

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              height: screenHeight * 0.25,
              child: Row(
                children: [
                  _image == null
                      ? Flexible(
                          flex: 4,
                          child: SizedBox(
                              // height: screenWidth / 2.5,
                              child: GestureDetector(
                            onTap: null,
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            ),
                          )),
                        )
                      : SizedBox(
                          height: screenHeight * 0.25,
                          child: SizedBox(
                              // height: screenWidth / 2.5,
                              child: GestureDetector(
                            onTap: null,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Container(
                                  decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: _image == null
                                      ? AssetImage(pathAsset)
                                      : FileImage(_image!) as ImageProvider,
                                  fit: BoxFit.fill,
                                ),
                              )),
                            ),
                          )),
                        ),
                  Flexible(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [],
                      ))
                ],
              )),
        ),
        Flexible(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
              child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    alignment: Alignment.center,
                    color: Theme.of(context).backgroundColor,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                      child: Text("PROFILE SETTINGS",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  //Menu List Here
                  Expanded(
                      child: ListView(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          shrinkWrap: true,
                          children: [
                        const MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE NAME"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        const MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE PHONE"),
                        ),
                        const MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE PASSWORD"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: _registerAccountDialog,
                          child: const Text("NEW REGISTRATION"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: _loginAccountDialog,
                          child: const Text("LOGIN"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        const MaterialButton(
                          onPressed: null,
                          child: Text("BUY CREDIT"),
                        ),
                        const Divider(
                          height: 2,
                        ),
                      ])),
                ],
              ),
            )),
      ],
    );
  }

  void _registerAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new Account",
            style: TextStyle(),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const RegistrationPage()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _loginAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Go to Login Page",
            style: TextStyle(),
          ),
          content: const Text(
            "Are you sure?",
            style: TextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginPage()));
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
