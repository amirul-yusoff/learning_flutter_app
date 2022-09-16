import 'package:app_kms/model/projectInfo.dart';
import 'package:app_kms/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DailyRecordCreatePage extends StatefulWidget {
  final User user;
  final ProjectInfo projectInfo;
  const DailyRecordCreatePage(
      {Key? key, required this.user, required this.projectInfo})
      : super(key: key);

  @override
  State<DailyRecordCreatePage> createState() => _DailyRecordCreatePageState();
}

class _DailyRecordCreatePageState extends State<DailyRecordCreatePage> {
  String dateActivityselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String dateEndselected = DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  final format = DateFormat("yyyy-MM-dd");

  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _siteActivitiesController =
      TextEditingController();
  List<String> _shiftSelection = <String>['Morning', 'Night'];
  var selectedShift;

  @override
  Widget build(BuildContext context) {
    late double screenHeight, screenWidth, resWidth, resHeight;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    int rowcount = 2;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowcount = 2;
    } else {
      resWidth = screenWidth * 0.75;
      rowcount = 3;
    }

    final ImagePicker imgpicker = ImagePicker();
    List<XFile>? imagefiles;
    openImages() async {
      try {
        var pickedfiles = await imgpicker.pickMultiImage();
        print("HERE.");
        //you can use ImageCourse.camera for Camera capture
        if (pickedfiles != null) {
          print("MANAGE.");

          // imagefiles = pickedfiles;
          setState(() {
            imagefiles = pickedfiles;
          });
          print(imagefiles);
          print(pickedfiles);
        } else {
          print("No image is selected.");
        }
      } catch (e) {
        print("error while picking file.");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Create Daily Record ' + widget.projectInfo.projectCode.toString()),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 5),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Table(
                      columnWidths: const {
                        0: FractionColumnWidth(0.3),
                        1: FractionColumnWidth(0.7)
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: [
                        TableRow(children: [
                          const Text('Project Code',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.projectInfo.projectCode.toString()),
                        ]),
                        TableRow(children: [
                          const Text('Project Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.projectInfo.projectShortName.toString()),
                        ]),
                        TableRow(children: [
                          const Text('HOD Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.projectInfo.hodName.toString()),
                        ]),
                        TableRow(children: [
                          const Text('PM Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.projectInfo.pmName.toString()),
                        ]),
                        TableRow(children: [
                          const Text('PE Name',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(widget.projectInfo.peName.toString()),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Flexible(
                flex: 10,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              DateTimeFormField(
                                dateFormat: format,
                                initialValue: DateTime.now(),
                                decoration: const InputDecoration(
                                  icon: Icon(
                                    Icons.event_note,
                                  ),
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  border: OutlineInputBorder(),
                                  labelText: 'Select Activity Date',
                                ),
                                mode: DateTimeFieldPickerMode.date,
                                autovalidateMode: AutovalidateMode.always,
                                onDateSelected: (DateTime date) {
                                  setState(() {
                                    String stringdate = date.toString();
                                    dateActivityselected =
                                        stringdate.replaceAll(
                                            RegExp(r' 00:00:00.000'), '');
                                    dateActivityselected = dateActivityselected;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: _shiftSelection,
                                dropdownSearchDecoration: const InputDecoration(
                                  labelText: "Choose Shift",
                                  hintText: "Shift",
                                  icon: Icon(
                                    Icons.sunny_snowing,
                                  ),
                                ),
                                onChanged: _shiftChange,
                                selectedItem: selectedShift,
                                showSearchBox: true,
                                searchFieldProps: const TextFieldProps(
                                  cursorColor: Colors.blue,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  textInputAction: TextInputAction.next,
                                  controller: _serialNumberController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      labelText: 'Serial Number',
                                      labelStyle: TextStyle(),
                                      icon: Icon(
                                        Icons.confirmation_number_rounded,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 2.0),
                                      ))),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                  // textInputAction: TextInputAction.next,
                                  maxLines: 10,
                                  controller: _siteActivitiesController,
                                  // keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    labelText: 'Site Activities',
                                    alignLabelWithHint: true,
                                    labelStyle: TextStyle(),
                                    icon: Icon(
                                      Icons.list_alt_outlined,
                                    ),
                                  )),
                              const SizedBox(
                                height: 60,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    fixedSize:
                                        Size(resWidth / 2, resWidth * 0.1)),
                                child: const Text('Create Record'),
                                onPressed: () => {
                                  _newRecordDialog(),
                                },
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Divider(),
                              Text("Picked Files:"),
                              Divider(),

                              Container(
                                child: imagefiles != null
                                    ? Wrap(
                                        children: imagefiles!.map((imageone) {
                                          return Container(
                                              child: Card(
                                            child: Container(
                                              height: 100,
                                              width: 100,
                                              child: Image.file(
                                                  File(imageone.path)),
                                            ),
                                          ));
                                        }).toList(),
                                      )
                                    : Container(
                                        child: Text("no Image"),
                                      ),
                              ),
                              //open button ----------------
                              ElevatedButton(
                                  onPressed: () {
                                    openImages();
                                  },
                                  child: Text("Open Images")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _newRecordDialog() {
    String _serialnumber = _serialNumberController.text;
    String _siteactivities = _siteActivitiesController.text;

    print(dateActivityselected);
    print(selectedShift);
    print(_serialnumber);
    print(_siteactivities);
  }

  Future _shiftChange(String? shift) async {
    setState(() {
      selectedShift = shift;
    });
  }
}
