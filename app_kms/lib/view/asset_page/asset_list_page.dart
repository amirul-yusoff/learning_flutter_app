import 'dart:convert';

import 'package:app_kms/view/model/assetList.dart';
import 'package:app_kms/view/model/config.dart';
import 'package:app_kms/view/model/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class AssetListPage extends StatefulWidget {
  final User user;
  const AssetListPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AssetListPage> createState() => _AssetListPageState();
}

class _AssetListPageState extends State<AssetListPage> {
  List<Map<String, dynamic>> _allAsset = [];
  List<Map<String, dynamic>> _foundAsset = [];

  Future getAllCategory() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Fetching Data"));
    progressDialog.show();
    var baseUrl = MyConfig.server + "/asset_list_pdo.php";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        var streetsFromJson = jsonData['project_data'];
        _foundAsset = List<Map<String, dynamic>>.from((streetsFromJson));
      });
    }
    progressDialog.dismiss();
  }

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getAllCategory();
    });
  }

  // This function is called whenever the text field changes
  Future<void> _runFilter(String enteredKeyword) async {
    var baseUrl = MyConfig.server + "/asset_list_pdo.php";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        var streetsFromJson = jsonData['project_data'];
        _allAsset = List<Map<String, dynamic>>.from((streetsFromJson));
      });
    }
    Fluttertoast.showToast(
        msg: "Finding Asset",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0);

    List<Map<String, dynamic>> results = [];

    if (enteredKeyword.isEmpty || enteredKeyword.length <= 3) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allAsset;
    } else {
      results = _allAsset
          .where((user) => user["device_name"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      Fluttertoast.showToast(
          msg: "Asset Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundAsset = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY Asset List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText:
                      'Search Asset Name (Please insert more than 3 caharacter)',
                  suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundAsset.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundAsset.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => {_getAssetInfo(index)},
                        child: Card(
                          key: ValueKey(_foundAsset[index]["id"]),
                          // color: Colors.amberAccent,
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          // margin: const EdgeInsets.symmetric(vertical: 10),
                          child: SizedBox(
                            // width: 300,
                            // height: 100,
                            child: ListTile(
                              leading: Text(
                                _foundAsset[index]["employee_code"].toString(),
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: Text(
                                  _foundAsset[index]['device_name'].toString()),
                              subtitle: Text(_foundAsset[index]["serial_number"]
                                  .toString()),
                              trailing: Text(_foundAsset[index]['employee_name']
                                  .toString()),
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _getAssetInfo(int index) {
    print("getProjectInfo");
    var ProjectID = _foundAsset[index]['id'];
    print(ProjectID);
  }
}
