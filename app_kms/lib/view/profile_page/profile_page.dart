import 'dart:convert';

import 'package:app_kms/model/config.dart';
import 'package:app_kms/model/user.dart';
import 'package:app_kms/view/main_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

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

  @override
  void initState() {
    super.initState();
    _findAsset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Detail'),
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/background.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SafeArea(
            child: Column(
          children: [
            //for circle avtar image
            _getHeader(),
            const SizedBox(
              height: 10,
            ),
            _profileName(widget.user.employeeName.toString()),
            const SizedBox(
              height: 14,
            ),
            _heading(widget.user.employeeCode.toString()),
            const SizedBox(
              height: 6,
            ),
            _detailsCard(),
            const SizedBox(
              height: 10,
            ),
            _heading("IT Asset"),
            const SizedBox(
              height: 6,
            ),
            _itAsset(),
            const Spacer(),
            logoutButton()
          ],
        )),
      ),
    );
  }

  Widget _getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
                //borderRadius: BorderRadius.all(Radius.circular(10.0)),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        MyConfig.server + "/images/users/images.png"))
                // color: Colors.orange[100],
                ),
          ),
        ),
      ],
    );
  }

  Widget _profileName(String name) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.80, //80% of width,
      child: Text(
        heading,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _detailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(widget.user.mbrEmail.toString()),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.hail_outlined),
              title: Text(widget.user.position.toString()),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
            ListTile(
              leading: const Icon(Icons.work_outline_rounded),
              title: Text(widget.user.department.toString()),
            ),
            const Divider(
              height: 0.6,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _itAsset() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            //row for each deatails
            for (var i = 1; i <= _foundUsers.length; i++)
              for (var i = 1; i <= _foundUsers.length; i++)
                ListTile(
                  leading: Icon(Icons.laptop_mac_outlined),
                  title: Text(_foundUsers[i - 1]["device_name"].toString()),
                ),
          ],
        ),
      ),
    );
  }

  Widget logoutButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.scale,
                duration: const Duration(seconds: 1),
                alignment: Alignment.center,
                child: MainPage(user: widget.user)));
      },
      child: Container(
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.backspace_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  "Back",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          )),
    );
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
