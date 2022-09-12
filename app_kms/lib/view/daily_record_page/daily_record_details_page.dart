import 'dart:convert';
import 'dart:math';
import 'package:app_kms/model/dailyRecordList.dart';
import 'package:app_kms/model/user.dart';
import 'package:app_kms/model/config.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:transparent_image/transparent_image.dart';

class DailyRecordDetails extends StatefulWidget {
  final User user;
  final DailyRecordList dailyRecordList;
  const DailyRecordDetails(
      {Key? key, required this.user, required this.dailyRecordList})
      : super(key: key);

  @override
  State<DailyRecordDetails> createState() => _DailyRecordDetailsState();
}

class _DailyRecordDetailsState extends State<DailyRecordDetails> {
  List<Map<String, dynamic>> _foundWorkorders = [];
  List<Map<String, dynamic>> _foundImages = [];
  TransformationController controller = TransformationController();
  String velocity = "VELOCITY";
  var percentages = double.parse('0.0');
  var calculate = double.parse('0.0');

  @override
  void initState() {
    super.initState();
    _findWorkProgress();
    _findImage();
    _calculatePercentages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Record Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  child: Container(
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
                            const Text('Record by',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.dailyRecordList.record_by.toString()),
                          ]),
                          TableRow(children: [
                            const Text('Project Code',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(
                                widget.dailyRecordList.project_code.toString()),
                          ]),
                          TableRow(children: [
                            const Text('Serial Number',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.dailyRecordList.serial_no.toString()),
                          ]),
                          TableRow(children: [
                            const Text('Daily Record Date',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.dailyRecordList.daily_record_date
                                .toString()),
                          ]),
                          TableRow(children: [
                            const Text('Shift',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.dailyRecordList.shift.toString()),
                          ]),
                          TableRow(children: [
                            const Text('Record Date',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.dailyRecordList.record_date.toString()),
                          ]),
                          TableRow(children: [
                            const Text('Site Activities',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.dailyRecordList.site_activity
                                .toString()),
                          ]),
                          TableRow(children: [
                            const Text('Problems',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.dailyRecordList.problem.toString()),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                for (var i = 1; i <= _foundWorkorders.length; i++)
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
                                percent: _foundWorkorders[i - 1]
                                        ["percentages"] ??
                                    0.0,
                                center: Text(_foundWorkorders[i - 1]
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
                                        Text('Workorder  $i',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(_foundWorkorders[i - 1]
                                                ["workorder_number"]
                                            .toString()),
                                      ]),
                                      TableRow(children: [
                                        const Text('Progress ID',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(_foundWorkorders[i - 1]
                                                ["daily_record_progress_id"]
                                            .toString()),
                                      ]),
                                      TableRow(children: [
                                        const Text('Workorder  Category',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(_foundWorkorders[i - 1]
                                                ["wo_category_short_name"]
                                            .toString()),
                                      ]),
                                      TableRow(children: [
                                        const Text('Work Done Today',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(_foundWorkorders[i - 1]
                                                ["work_done_today"]
                                            .toString()),
                                      ]),
                                      TableRow(children: [
                                        const Text('Total Work Done',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(_foundWorkorders[i - 1]
                                                ["sum_workdone"]
                                            .toString()),
                                      ]),
                                      TableRow(children: [
                                        const Text('Total Qty',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(_foundWorkorders[i - 1]
                                                ["total_qty"]
                                            .toString()),
                                      ]),
                                      TableRow(children: [
                                        const Text('Balance Qty',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)),
                                        Text(_foundWorkorders[i - 1]["balance"]
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
                for (var i = 1; i <= _foundImages.length; i++)
                  Card(
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Center(
                          child: InteractiveViewer(
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: _foundImages[i - 1]["path"],
                            ),
                            // Image.network(_foundImages[i - 1]["path"]),
                            transformationController: controller,
                            boundaryMargin: const EdgeInsets.all(5.0),
                            onInteractionEnd: (ScaleEndDetails endDetails) {
                              controller.value = Matrix4.identity();
                              setState(() {
                                velocity = endDetails.velocity.toString();
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _findWorkProgress() {
    http.post(Uri.parse(MyConfig.server + "/daily_record_find_progress.php"),
        body: {
          "daily_record_id": widget.dailyRecordList.daily_record_id.toString(),
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Fetching Daily Record",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          var streetsFromJson = jsondata['project_data'];
          _foundWorkorders = List<Map<String, dynamic>>.from((streetsFromJson));
          _findWorkOrderCategoriesSumWorkDones();
          _findWorkOrderCategoriesQty();
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

  _findImage() {
    http.post(Uri.parse(MyConfig.server + "/daily_record_find_image.php"),
        body: {
          "daily_record_id": widget.dailyRecordList.daily_record_id.toString(),
        }).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Fetching Image",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          var streetsFromJson = jsondata['project_data'];
          _foundImages = List<Map<String, dynamic>>.from((streetsFromJson));
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
    for (var i = 0; i < _foundWorkorders.length; i++) {
      http.post(Uri.parse(MyConfig.server + "/find_daily_record_work_done.php"),
          body: {
            "workorder_number":
                _foundWorkorders[i]['workorder_number'].toString(),
            "wo_category_short_name":
                _foundWorkorders[i]['wo_category_short_name'].toString(),
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
            _foundWorkorders[i]['sum_workdone'] =
                jsondata['project_data'][0]['sum'].toString();
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

  _findWorkOrderCategoriesQty() {
    for (var i = 0; i < _foundWorkorders.length; i++) {
      http.post(
          Uri.parse(
              MyConfig.server + "/find_daily_record_work_categories_qty.php"),
          body: {
            "workorder_number":
                _foundWorkorders[i]['workorder_number'].toString(),
            "wo_category_short_name":
                _foundWorkorders[i]['wo_category_short_name'].toString(),
          }).then((response) {
        var jsondata = jsonDecode(response.body);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Calculating Total Qty",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          setState(() {
            _foundWorkorders[i]['total_qty'] =
                jsondata['project_data'][0]['sum'].toString();
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
    for (var i = 0; i < _foundWorkorders.length; i++) {
      var workdone = _foundWorkorders[i]['sum_workdone'];
      if (workdone.isEmpty) {
        workdone = '0.0';
      }
      workdone = double.parse(workdone);

      var allqty = _foundWorkorders[i]['total_qty'];
      if (allqty.isEmpty) {
        allqty = '0.0';
      }
      allqty = double.parse(allqty);

      calculate = workdone / allqty;

      _foundWorkorders[i]['balance'] = roundDouble(allqty - workdone, 3);
      _foundWorkorders[i]['percentages'] = roundDouble(calculate, 3);
      _foundWorkorders[i]['in_percentages'] = roundDouble(calculate * 100, 3);
    }
    ;
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
