import 'dart:convert';
import 'dart:math';

import 'package:app_kms/model/user.dart';
import 'package:app_kms/model/workorder.dart';
import 'package:app_kms/model/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';

class WorkorderDetailsPage extends StatefulWidget {
  final User user;
  final Workorders workorders;
  const WorkorderDetailsPage(
      {Key? key, required this.user, required this.workorders})
      : super(key: key);

  @override
  State<WorkorderDetailsPage> createState() => _WorkorderDetailsPageState();
}

class _WorkorderDetailsPageState extends State<WorkorderDetailsPage> {
  List<Map<String, dynamic>> _foundWorkCategories = [];
  var percentages = double.parse('0.0');
  var calculate = double.parse('0.0');
  @override
  void initState() {
    super.initState();
    _getWorkCategoryInfo();
    // _calculatePercentages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workorders.workOrderNumber.toString()),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (_foundWorkCategories.isEmpty)
                const Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'No results found',
                      style: TextStyle(fontSize: 34),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              for (var i = 1; i <= _foundWorkCategories.length; i++)
                Center(
                    child: Column(
                  children: [
                    Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CircularPercentIndicator(
                              animation: true,
                              animationDuration: 3400,
                              radius: 60.0,
                              lineWidth: 10.0,
                              percent: _foundWorkCategories[i - 1]
                                      ["percentages"] ??
                                  0.0,
                              center: Text(_foundWorkCategories[i - 1]
                                          ["in_percentages"]
                                      .toString() +
                                  '%'),
                              progressColor: Colors.green,
                              // circularStrokeCap: CircularStrokeCap.round,
                            ),
                            Container(
                              padding: const EdgeInsets.all(20),
                              child: SingleChildScrollView(
                                child: Table(
                                  columnWidths: const {
                                    0: FractionColumnWidth(0.3),
                                    1: FractionColumnWidth(0.7)
                                  },
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.top,
                                  children: [
                                    TableRow(children: [
                                      Text('Category  $i',
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text(_foundWorkCategories[i - 1]
                                              ["wo_category_short_name"]
                                          .toString()),
                                    ]),
                                    TableRow(children: [
                                      const Text('Workorder',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text(_foundWorkCategories[i - 1]
                                              ["workorder"]
                                          .toString()),
                                    ]),
                                    TableRow(children: [
                                      const Text('Work Done Qty',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text(_foundWorkCategories[i - 1]
                                              ["sum_workdone"]
                                          .toString()),
                                    ]),
                                    TableRow(children: [
                                      const Text('Total Qty',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text(_foundWorkCategories[i - 1]
                                              ["sum_all_qty"]
                                          .toString()),
                                    ]),
                                    TableRow(children: [
                                      const Text('Balance Qty',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold)),
                                      Text(_foundWorkCategories[i - 1]
                                              ["balance"]
                                          .toString()),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                )),
            ],
          ),
        ),
      ),
    );
  }

  _getWorkCategoryInfo() {
    http.post(
        Uri.parse(MyConfig.server + "/project_code_find_workcategories.php"),
        body: {
          "workorder": widget.workorders.workOrderNumber.toString()
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Fetching Work Categories Record",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          var streetsFromJson = jsondata['project_data'];
          _foundWorkCategories =
              List<Map<String, dynamic>>.from((streetsFromJson));
          _findWorkOrderCategoriesSumWorkDones();
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

  _findWorkOrderCategoriesSumWorkDones() {
    for (var i = 0; i < _foundWorkCategories.length; i++) {
      http.post(Uri.parse(MyConfig.server + "/find_daily_record_work_done.php"),
          body: {
            "workorder_number": _foundWorkCategories[i]['workorder'].toString(),
            "wo_category_short_name":
                _foundWorkCategories[i]['wo_category_short_name'].toString(),
          }).then((response) {
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Calculating Work Done ",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          setState(() {
            var checkNull = jsondata['project_data'][0]['sum'] ?? 0.0;
            _foundWorkCategories[i]['sum_workdone'] = checkNull.toString();
            _calculatePercentages();
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

  _calculatePercentages() {
    for (var i = 0; i < _foundWorkCategories.length; i++) {
      var workdone = _foundWorkCategories[i]['sum_workdone'];
      var allqty = _foundWorkCategories[i]['sum_all_qty'];

      if (workdone.isEmpty) {
        workdone = '0.0';
      }
      workdone = double.parse(workdone);

      if (allqty.isEmpty) {
        allqty = '0.0';
      }
      allqty = double.parse(allqty);

      calculate = workdone / allqty;

      _foundWorkCategories[i]['balance'] = roundDouble(allqty - workdone, 3);
      _foundWorkCategories[i]['percentages'] = roundDouble(calculate, 3);
      _foundWorkCategories[i]['in_percentages'] =
          roundDouble(calculate * 100, 3);
    }
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
