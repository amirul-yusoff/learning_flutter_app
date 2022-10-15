import 'dart:convert';

import 'package:app_kms/model/config.dart';
import 'package:app_kms/model/projectInfo.dart';
import 'package:app_kms/model/user.dart';
import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

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

  final TextEditingController _serialNumberController = TextEditingController();
  final TextEditingController _workdoneQtyController = TextEditingController();
  final TextEditingController _siteActivitiesController =
      TextEditingController();
  List<String> _shiftSelection = <String>['Morning', 'Night'];
  var selectedShift;

  final ImagePicker imgpickerProgress = ImagePicker();
  final ImagePicker imgpickerSLD = ImagePicker();
  final ImagePicker imgpickerToolbox = ImagePicker();
  final ImagePicker imgpickerDo = ImagePicker();
  final ImagePicker imgpickerGiSlip = ImagePicker();
  final ImagePicker imgpickerJMS = ImagePicker();
  final ImagePicker imgpickerDR = ImagePicker();
  List<XFile>? imagefilesProgress;
  List<XFile>? imagefilesSLD;
  List<XFile>? imagefilesToolbox;
  List<XFile>? imagefilesDo;
  List<XFile>? imagefilesGiSlip;
  List<XFile>? imagefilesJMS;
  List<XFile>? imagefilesDR;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  int workorderCount = 1;
  List<int> text = [0];
  List<String> _LWorkorder = <String>[];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getWorkorder();
    });
  }

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

    return Scaffold(
        appBar: AppBar(
          title: Text('Create Daily Record ' +
              widget.projectInfo.projectCode.toString()),
        ),
        body: Center(
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
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
                            const Text('Project Code',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(widget.projectInfo.projectCode.toString()),
                          ]),
                          TableRow(children: [
                            const Text('Project Name',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(
                                widget.projectInfo.projectShortName.toString()),
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
              ),
              Flexible(
                  flex: 8,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
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
                                  border: OutlineInputBorder(),
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
                                      border: OutlineInputBorder(),
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
                                    border: OutlineInputBorder(),
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
                                child: const Text('Add Workorder'),
                                onPressed: () => {
                                  onAddForm(),
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              workorderCount != 0
                                  ? Column(
                                      children: [
                                        for (var i in text)
                                          Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Text("Workorder " +
                                                        (i + 1).toString()),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    DropdownSearch<String>(
                                                      mode: Mode.DIALOG,
                                                      showSelectedItems: true,
                                                      items: _LWorkorder,
                                                      dropdownSearchDecoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            "Choose Workorder",
                                                        hintText: "Workorder",
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                      onChanged:
                                                          _changeWorkorder,
                                                      showSearchBox: true,
                                                      searchFieldProps:
                                                          const TextFieldProps(
                                                        cursorColor:
                                                            Colors.blue,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    DataTable(
                                                      columns: const <
                                                          DataColumn>[
                                                        DataColumn(
                                                          label: Expanded(
                                                            child: Text(
                                                              'Work\nCategories',
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Expanded(
                                                            child: Text(
                                                              'Total\nQty',
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Expanded(
                                                            child: Text(
                                                              'Accumulative\nQty',
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Expanded(
                                                            child: Text(
                                                              'Today\nQty',
                                                              style: TextStyle(
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .italic),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      rows: const <DataRow>[
                                                        DataRow(
                                                          cells: <DataCell>[
                                                            DataCell(
                                                                Text('Sarah')),
                                                            DataCell(
                                                                Text('19')),
                                                            DataCell(Text(
                                                                'Student')),
                                                            DataCell(
                                                                Text('asdasd')),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    )
                                  : Container(
                                      // child: Text("Down"),
                                      ),
                              const SizedBox(
                                height: 20,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                elevation: 10,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //open button Progress----------------
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              resWidth / 2, resWidth * 0.1)),
                                      child:
                                          const Text('Choose Progress Image'),
                                      onPressed: () => {
                                        openImages(),
                                      },
                                    ),
                                    const Divider(),
                                    const Text("Picked Progress Image:"),
                                    const Divider(),
                                    imagefilesProgress != null
                                        ? Wrap(
                                            children: imagefilesProgress!
                                                .map((imageone) {
                                              return Container(
                                                  child: Card(
                                                      child: Column(
                                                children: [
                                                  Container(
                                                    height: 100,
                                                    width: 100,
                                                    child: Image.file(
                                                        File(imageone.path)),
                                                  ),
                                                  const Positioned(
                                                    right: 5.0,
                                                    child: InkWell(
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        size: 30,
                                                        color: Colors.red,
                                                      ),
                                                      onTap: null,
                                                    ),
                                                  ),
                                                ],
                                              )));
                                            }).toList(),
                                          )
                                        : Container(
                                            child:
                                                const Text("No Image Selected"),
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                elevation: 10,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //open button SLD----------------
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              resWidth / 2, resWidth * 0.1)),
                                      child: const Text('Choose SLD Image'),
                                      onPressed: () => {
                                        openImagesSLD(),
                                      },
                                    ),
                                    const Divider(),
                                    const Text("Picked SLD Image:"),
                                    const Divider(),
                                    imagefilesSLD != null
                                        ? Wrap(
                                            children:
                                                imagefilesSLD!.map((imageone) {
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
                                            child:
                                                const Text("No Image Selected"),
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                elevation: 10,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //open button Toolbox----------------
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              resWidth / 2, resWidth * 0.1)),
                                      child: const Text('Choose Toolbox Image'),
                                      onPressed: () => {
                                        openImagesToolbox(),
                                      },
                                    ),
                                    const Divider(),
                                    const Text("Picked Toolbox Image:"),
                                    const Divider(),
                                    imagefilesToolbox != null
                                        ? Wrap(
                                            children: imagefilesToolbox!
                                                .map((imageone) {
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
                                            child:
                                                const Text("No Image Selected"),
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                elevation: 10,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //open button Do----------------
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              resWidth / 2, resWidth * 0.1)),
                                      child: const Text('Choose Do Image'),
                                      onPressed: () => {
                                        openImagesDo(),
                                      },
                                    ),
                                    const Divider(),
                                    const Text("Picked Do Image:"),
                                    const Divider(),
                                    imagefilesDo != null
                                        ? Wrap(
                                            children:
                                                imagefilesDo!.map((imageone) {
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
                                            child:
                                                const Text("No Image Selected"),
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                elevation: 10,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //open button GiSlip----------------
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              resWidth / 2, resWidth * 0.1)),
                                      child: const Text('Choose Gi Slip Image'),
                                      onPressed: () => {
                                        openImagesGiSlip(),
                                      },
                                    ),
                                    const Divider(),
                                    const Text("Picked Gi Slip Image:"),
                                    const Divider(),
                                    imagefilesGiSlip != null
                                        ? Wrap(
                                            children: imagefilesGiSlip!
                                                .map((imageone) {
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
                                            child:
                                                const Text("No Image Selected"),
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                elevation: 10,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //open button JMS----------------
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              resWidth / 2, resWidth * 0.1)),
                                      child: const Text('Choose JMS Image'),
                                      onPressed: () => {
                                        openImagesJMS(),
                                      },
                                    ),
                                    const Divider(),
                                    const Text("Picked JMS Image:"),
                                    const Divider(),
                                    imagefilesJMS != null
                                        ? Wrap(
                                            children:
                                                imagefilesJMS!.map((imageone) {
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
                                            child:
                                                const Text("No Image Selected"),
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                elevation: 10,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    //open button DR----------------
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: Size(
                                              resWidth / 2, resWidth * 0.1)),
                                      child: const Text(
                                          'Choose Daily Record Image'),
                                      onPressed: () => {
                                        openImagesDR(),
                                      },
                                    ),
                                    const Divider(),
                                    const Text("Picked Daily Record Image:"),
                                    const Divider(),
                                    imagefilesDR != null
                                        ? Wrap(
                                            children:
                                                imagefilesDR!.map((imageone) {
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
                                            child:
                                                const Text("No Image Selected"),
                                          ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ));
  }

  // void selectImages() async {
  //   final List<XFile>? selectedImages = await imagePicker.pickMultiImage();
  //   if (selectedImages!.isNotEmpty) {
  //     imageFileList!.addAll(selectedImages);
  //   }
  //   print("Image List Length:" + imageFileList!.length.toString());
  //   setState(() {});
  // }

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

  openImages() async {
    try {
      var pickedfilesProgress = await imgpickerProgress.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfilesProgress != null) {
        imagefilesProgress = pickedfilesProgress;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  _deleteImages() {
    print("deleteImages");
  }

  openImagesSLD() async {
    try {
      var pickedfilesSLD = await imgpickerSLD.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfilesSLD != null) {
        imagefilesSLD = pickedfilesSLD;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  openImagesToolbox() async {
    try {
      var pickedfilesToolbox = await imgpickerToolbox.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfilesToolbox != null) {
        imagefilesToolbox = pickedfilesToolbox;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  openImagesDo() async {
    try {
      var pickedfilesDo = await imgpickerDo.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfilesDo != null) {
        imagefilesDo = pickedfilesDo;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  openImagesGiSlip() async {
    try {
      var pickedfilesGiSlip = await imgpickerGiSlip.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfilesGiSlip != null) {
        imagefilesGiSlip = pickedfilesGiSlip;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  openImagesJMS() async {
    try {
      var pickedfilesJMS = await imgpickerJMS.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfilesJMS != null) {
        imagefilesJMS = pickedfilesJMS;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  openImagesDR() async {
    try {
      var pickedfilesDR = await imgpickerDR.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfilesDR != null) {
        imagefilesDR = pickedfilesDR;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  ///on add form
  void onAddForm() {
    setState(() {
      text.add(workorderCount++);
    });
    print(workorderCount);
  }

  Future getWorkorder() async {
    http.post(Uri.parse(MyConfig.server + "/find_workorder_by_project.php"),
        body: {
          "projectCode": widget.projectInfo.projectCode.toString(),
        }).then((response) {
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Fetching Workorder",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        setState(() {
          for (var i = 0; i < jsonData['project_data'].length; i++) {
            _LWorkorder.add(
                jsonData['project_data'][i]['WorkOrderNumber'].toString());
          }
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

  _changeWorkorder(String? workorder) async {
    print(workorder);
    print(MyConfig.server + "/find_workorder_categories_by_project.php");
    http.post(
        Uri.parse(
            MyConfig.server + "/find_workorder_categories_by_project.php"),
        body: {
          "workorder": workorder.toString(),
        }).then((response) {
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Fetching Workorder",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        print(jsonData['project_data']);
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
