import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/config.dart';
import 'model/dailyRecordList.dart';
import 'model/user.dart';

class DailyRecordPage extends StatefulWidget {
  final User user;
  const DailyRecordPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DailyRecordPage> createState() => _DailyRecordPageState();
}

class _DailyRecordPageState extends State<DailyRecordPage> {
  List assetlist = [];
  List dailyRecordlist = [];
  String titlecenter = "Loading Daily Record List...";
  late double screenHeight, screenWidth, resWidth;
  final df = '';
  late ScrollController _scrollController;
  int scrollcount = 10;
  int rowcount = 2;
  int numprd = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text('Daily Record'),
        ),
        body: assetlist.isEmpty
            ? Center(
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)))
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text("Your Current Asset",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  Text(numprd.toString() + " found"),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: rowcount,
                      controller: _scrollController,
                      children: List.generate(scrollcount, (index) {
                        return Card(
                            child: InkWell(
                          onTap: () => {_prodDetails(index)},
                          child: Column(
                            children: [
                              Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            truncateString(assetlist[index]
                                                    ['daily_record_id']
                                                .toString()),
                                            style: TextStyle(
                                                fontSize: resWidth * 0.045,
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            truncateString(assetlist[index]
                                                    ['project_code']
                                                .toString()),
                                            style: TextStyle(
                                                fontSize: resWidth * 0.045,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ));
                      }),
                    ),
                  ),
                ],
              ));
  }

  String truncateString(String str) {
    if (str.length > 15) {
      str = str.substring(0, 15);
      return str + "...";
    } else {
      return str;
    }
  }

  void _loadProducts() {
    if (widget.user.username == "na") {
      setState(() {
        titlecenter = "Unregistered User";
      });
      return;
    }
    http.post(Uri.parse(MyConfig.server + "/daily_record_list.php"),
        body: {'username': widget.user.username.toString()}).then((response) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      if (response.statusCode == 200) {
        var extractdata = parsedJson['data'];
        setState(() {
          assetlist = extractdata;
          numprd = assetlist.length;
          if (scrollcount >= assetlist.length) {
            scrollcount = assetlist.length;
          }
        });
      } else {
        setState(() {
          titlecenter = "No Data";
        });
      }
    });
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        if (assetlist.length > scrollcount) {
          scrollcount = scrollcount + 10;
          if (scrollcount >= assetlist.length) {
            scrollcount = assetlist.length;
          }
        }
      });
    }
  }

  _prodDetails(int index) async {
    print("prodDetails");
    DailyRecordList dailyRecordList = DailyRecordList(
      daily_record_id: assetlist[index]['daily_record_id'],
      serial_no: assetlist[index]['serial_no'],
      project_code: assetlist[index]['project_code'],
      site_activity: assetlist[index]['site_activity'],
    );

    // await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => PrDetailsOwnerPage(
    //               product: product,
    //             )));
    _loadProducts();
  }
}
