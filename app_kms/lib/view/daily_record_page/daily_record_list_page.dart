import 'dart:convert';

import 'package:app_kms/model/dailyRecordList.dart';
import 'package:app_kms/model/user.dart';
import 'package:app_kms/view/daily_record_page/daily_record_details_page.dart';
import 'package:app_kms/model/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class DailyRecordPage extends StatefulWidget {
  final User user;
  const DailyRecordPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DailyRecordPage> createState() => _DailyRecordPageState();
}

class _DailyRecordPageState extends State<DailyRecordPage> {
  // We will fetch data from this Rest api
  // final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final _baseUrl = MyConfig.server + "/daily_record_list_with_pagination.php";

  // At the beginning, we fetch the first 20 posts
  int _page = 1;
  // you can change this value to fetch more or less posts per page (10, 15, 5, etc)
  final int _limit = 20;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
      setState(() {
        var jsonData = json.decode(res.body);
        var streetsFromJson = jsonData['project_data'];
        _posts = streetsFromJson;
      });
    } catch (err) {
      if (kDebugMode) {
        print('Something went wrong');
      }
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
        var jsonData = json.decode(res.body);
        var streetsFromJson = jsonData['project_data'];
        final List fetchedPosts = streetsFromJson;
        if (fetchedPosts.isNotEmpty) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        if (kDebugMode) {
          print('Something went wrong!');
        }
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Record List'),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _posts.length,
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () => {
                        _getProjectInfo(
                            _posts[index]["daily_record_id"].toString())
                      },
                      child: Card(
                        elevation: 4,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 10),
                        child: ListTile(
                          leading: Text(
                            (index + 1).toString() +
                                ")" +
                                _posts[index]['project_code'].toString(),
                            style: const TextStyle(fontSize: 24),
                          ),
                          title: Text("Serial No : " +
                              _posts[index]['serial_no'].toString() +
                              "\n(" +
                              _posts[index]['record_date'].toString() +
                              ")\n"),
                          subtitle:
                              Text(_posts[index]["site_activity"].toString()),
                          trailing: Text(_posts[index]['record_by'].toString()),
                        ),
                      ),
                    ),
                  ),
                ),

                // when the _loadMore function is running
                if (_isLoadMoreRunning == true)
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                // When nothing else to load
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 40),
                    color: Colors.amber,
                    child: const Center(
                      child: Text('You have fetched all of the content'),
                    ),
                  ),
              ],
            ),
    );
  }

  void _getProjectInfo(String dailyRecordID) {
    print(dailyRecordID);

    http.post(Uri.parse(MyConfig.server + "/daily_record_details.php"),
        body: {"dailyRecordID": dailyRecordID}).then((response) {
      print(response.statusCode);

      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var streetsFromJson = jsondata['project_data'][0];
        DailyRecordList dailyRecordList =
            DailyRecordList.fromJson(streetsFromJson);
        Fluttertoast.showToast(
            msg: "Fetching....",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => DailyRecordDetails(
                    user: widget.user, dailyRecordList: dailyRecordList)));
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
