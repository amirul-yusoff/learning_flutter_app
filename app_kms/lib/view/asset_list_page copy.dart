import 'dart:convert';

import 'package:app_kms/view/model/assetList.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/user.dart';
import 'model/config.dart';

class AssetListPage extends StatefulWidget {
  final User user;
  const AssetListPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AssetListPage> createState() => _AssetListPageState();
}

class _AssetListPageState extends State<AssetListPage> {
  List assetlist = [];
  String titlecenter = "Loading Asset List...";
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
          title: const Text('MY Asset List'),
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
                              // Flexible(
                              // flex: 6,
                              // child:
                              // CachedNetworkImage(
                              //   width: screenWidth,
                              //   fit: BoxFit.cover,
                              //   imageUrl: MyConfig.server +
                              //       "/mypasar/images/products/" +
                              //       assetlist[index]['product_id'] +
                              //       ".png",
                              //   placeholder: (context, url) =>
                              //       const LinearProgressIndicator(),
                              //   errorWidget: (context, url, error) =>
                              //       const Icon(Icons.error),
                              // ),
                              // ),
                              Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                            truncateString(assetlist[index]
                                                    ['device_name']
                                                .toString()),
                                            style: TextStyle(
                                                fontSize: resWidth * 0.045,
                                                fontWeight: FontWeight.bold)),
                                        Text(truncateString(assetlist[index]
                                                ['serial_number']
                                            .toString())),
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

  void _loadProducts() {
    if (widget.user.username == "na") {
      setState(() {
        titlecenter = "Unregistered User";
      });
      return;
    }
    var userID = "0";
    if (widget.user.username == null) {
      userID = "0";
    } else {
      userID = widget.user.username.toString();
    }
    http.post(Uri.parse(MyConfig.server + "/asset_list.php"),
        body: {'username': userID}).then((response) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      var temp = parsedJson['codeResponse'];
      if (temp == 200) {
        var extractdata = parsedJson['data'];
        print(extractdata);
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

  String truncateString(String str) {
    if (str.length > 15) {
      str = str.substring(0, 15);
      return str + "...";
    } else {
      return str;
    }
  }

  _prodDetails(int index) async {
    AssetList product = AssetList(
      id: assetlist[index]['id'],
      deviceName: assetlist[index]['device_name'],
      buyDate: assetlist[index]['buy_date'],
      description: assetlist[index]['description'],
      warrantyStart: assetlist[index]['warranty_start'],
      warrantyEnd: assetlist[index]['warranty_end'],
      supplier: assetlist[index]['supplier'],
      poName: assetlist[index]['po_name'],
      createdBy: assetlist[index]['created_by'],
      ram: assetlist[index]['ram'],
      capacity: assetlist[index]['capacity'],
      processor: assetlist[index]['processor'],
      serialNumber: assetlist[index]['serial_number'],
      department: assetlist[index]['department'],
    );

    // await Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => PrDetailsOwnerPage(
    //               product: product,
    //             )));
    _loadProducts();
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
}
