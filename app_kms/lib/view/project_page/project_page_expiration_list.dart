import 'dart:convert';

import 'package:app_kms/model/projectDetails.dart';
import 'package:app_kms/model/user.dart';
import 'package:app_kms/model/config.dart';
import 'package:app_kms/view/project_page/project_page_details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class ProjetExpiredPage extends StatefulWidget {
  final User user;
  const ProjetExpiredPage({Key? key, required this.user}) : super(key: key);

  @override
  State<ProjetExpiredPage> createState() => _ProjetExpiredPageState();
}

class _ProjetExpiredPageState extends State<ProjetExpiredPage> {
  List<Map<String, dynamic>> _allProject = [];
  List<Map<String, dynamic>> _foundUsers = [];

  Future getAllCategory() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Fetching Data"));
    progressDialog.show();
    var baseUrl = MyConfig.server + "/project_code_expired_list.php";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        var streetsFromJson = jsonData['project_data'];
        _foundUsers = List<Map<String, dynamic>>.from((streetsFromJson));
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
    var baseUrl = MyConfig.server + "/project_code_expired_list.php";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        var streetsFromJson = jsonData['project_data'];
        _allProject = List<Map<String, dynamic>>.from((streetsFromJson));
      });
    }
    Fluttertoast.showToast(
        msg: "Finding Project",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14.0);
    List<Map<String, dynamic>> results = [];

    if (enteredKeyword.isEmpty || enteredKeyword.length <= 3) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allProject;
    } else {
      results = _allProject
          .where((user) => user["Project_Code"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      Fluttertoast.showToast(
          msg: "Project Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Expired'),
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
                      'Search Project (Please insert more than 3 caharacter)',
                  suffixIcon: Icon(Icons.search)),
            ),
            Text("Result Found : " + _foundUsers.length.toString()),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => {_getProjectInfo(index)},
                        child: Card(
                          key: ValueKey(_foundUsers[index]["Project_Code"]),
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
                                _foundUsers[index]["Project_Code"].toString(),
                                style: const TextStyle(fontSize: 24),
                              ),
                              title: Text(_foundUsers[index]
                                      ['Project_Short_name']
                                  .toString()),
                              subtitle: Text(_foundUsers[index]["Project_Title"]
                                  .toString()),
                              trailing: Text(_foundUsers[index]
                                      ['Project_Status']
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

  void _getProjectInfo(int index) {
    print(MyConfig.server + "/project_code_find_id.php");
    var ProjectID = _foundUsers[index]['Project_ID'];
    var ProjectCode = _foundUsers[index]['Project_Code'];
    ProjectDetails projectdetails = ProjectDetails(
      _foundUsers[index]['Project_ID'].toString(),
      _foundUsers[index]['Project_Code'].toString(),
      _foundUsers[index]['Project_Short_name'].toString(),
      _foundUsers[index]['project_type'].toString(),
      _foundUsers[index]['project_team'].toString(),
      _foundUsers[index]['Project_Status'].toString(),
      _foundUsers[index]['Project_Client'].toString(),
      _foundUsers[index]['MainCon1'].toString(),
      _foundUsers[index]['Maincon2'].toString(),
      _foundUsers[index]['Project_Title'].toString(),
      _foundUsers[index]['Project_Contract_No'].toString(),
      _foundUsers[index]['project_tender_no'].toString(),
      _foundUsers[index]['tender_id'].toString(),
      _foundUsers[index]['project_contract_period'].toString(),
      _foundUsers[index]['Project_PO_No'].toString(),
      _foundUsers[index]['contract_original_value'].toString(),
      _foundUsers[index]['contract_vo_value'].toString(),
      _foundUsers[index]['Tarikh_Pesanan'].toString(),
      _foundUsers[index]['Project_Commencement_Date'].toString(),
      _foundUsers[index]['Project_Completion_Date'].toString(),
      _foundUsers[index]['contract_eot'].toString(),
      _foundUsers[index]['Project_Close_Date'].toString(),
      _foundUsers[index]['Project_Liquidity_And_Damages'].toString(),
      _foundUsers[index]['Project_Defect_Liability_Period'].toString(),
      _foundUsers[index]['project_client_gm'].toString(),
      _foundUsers[index]['project_client_kj'].toString(),
      _foundUsers[index]['Project_Client_Manager'].toString(),
      _foundUsers[index]['Project_Client_Engineer'].toString(),
      _foundUsers[index]['Project_Client_Supervisor'].toString(),
      _foundUsers[index]['project_client_foman'].toString(),
      _foundUsers[index]['Project_Prepared_by'].toString(),
      _foundUsers[index]['Project_Date_Prepared'].toString(),
      _foundUsers[index]['Project_Important_Note'].toString(),
      _foundUsers[index]['Retention'].toString(),
      _foundUsers[index]['EntryDate'].toString(),
      _foundUsers[index]['zone_code'].toString(),
      _foundUsers[index]['location'].toString(),
      _foundUsers[index]['latitude'].toString(),
      _foundUsers[index]['longitude'].toString(),
      _foundUsers[index]['isdelete'].toString(),
      _foundUsers[index]['Project_Coordinator'].toString(),
      _foundUsers[index]['Project_Supervisor'].toString(),
      _foundUsers[index]['created_at'].toString(),
      _foundUsers[index]['updated_at'].toString(),
      _foundUsers[index]['project_gross_profit'].toString(),
      _foundUsers[index]['consultant'].toString(),
      _foundUsers[index]['awarded_party'].toString(),
      _foundUsers[index]['po_value'].toString(),
      _foundUsers[index]['vendor_bulk_private'].toString(),
      _foundUsers[index]['po_no'].toString(),
      _foundUsers[index]['insurance_project_code'].toString(),
      _foundUsers[index]['insurance_lost_amount'].toString(),
      _foundUsers[index]['license_company'].toString(),
      _foundUsers[index]['is_office'].toString(),
      _foundUsers[index]['client_pic'].toString(),
      _foundUsers[index]['license_fee_amount'].toString(),
      _foundUsers[index]['license_fee_percentage'].toString(),
    );

    http.post(Uri.parse(MyConfig.server + "/project_code_find_id.php"), body: {
      "projectid": ProjectID.toString(),
    }).then((response) {
      var jsondata = jsonDecode(response.body);
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProjectDetailsPage(
                  user: widget.user,
                  projectdetails: projectdetails,
                )));
  }
}
