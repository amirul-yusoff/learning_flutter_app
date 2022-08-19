import 'package:flutter/material.dart';

class TabPage3 extends StatefulWidget {
  const TabPage3({Key? key}) : super(key: key);

  @override
  State<TabPage3> createState() => _TabPage3State();
}

class _TabPage3State extends State<TabPage3> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Flexible(
            flex: 4,
            child: Card(
              elevation: 10,
              child: Row(
                children: [
                  Flexible(flex: 4, child: Container()),
                  Flexible(
                      flex: 6,
                      child: Column(
                        children: const [Text("here")],
                      ))
                ],
              ),
            )),
        Flexible(
            flex: 6,
            child: Column(
              children: [
                Container(
                  child: const Center(
                    child: Text("PROFILE SETTINGS",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Expanded(
                  child: ListView(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      shrinkWrap: true,
                      children: const [
                        MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE NAME"),
                        ),
                        Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE PASWORD"),
                        ),
                        Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: null,
                          child: Text("UPDATE LOCATION"),
                        ),
                        Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: _registerAccount,
                          child: Text("NEW REGISTERATION"),
                        ),
                        Divider(
                          height: 2,
                        ),
                        MaterialButton(
                          onPressed: null,
                          child: Text("Login"),
                        ),
                        Divider(
                          height: 2,
                        ),
                      ]),
                ),
              ],
            )),
      ],
    ));
  }
}

void _registerAccount() {}
