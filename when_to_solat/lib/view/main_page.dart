import 'dart:convert';
import 'package:ndialog/ndialog.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;
import 'package:when_to_solat/view/flutter_qiblah.dart';

class MainPage extends StatefulWidget {
  static const customSwatch = MaterialColor(
    0xFFFF5252,
    <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFFF5252),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> _LStates = <String>[];
  List<String> _LArea = <String>[];
  var selectedstate;
  var selectedarea;
  var dataOne;
  var dataTwo;
  var dataThree;
  var dataFour;
  var dataFive;
  var dataSix;
  var dataSeven;

  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getState();
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
        title: const Text("AZAN"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/Azan_Main_Page.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.2), BlendMode.dstATop),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: _LStates,
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Choose The State",
                  hintText: "State",
                ),
                popupItemDisabled: isItemDisabled,
                onChanged: itemSelectionChanged,
                //selectedItem: "",
                showSearchBox: true,
                searchFieldProps: const TextFieldProps(
                  cursorColor: Colors.blue,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownSearch<String>(
                mode: Mode.DIALOG,
                showSelectedItems: true,
                items: _LArea,
                dropdownSearchDecoration: const InputDecoration(
                  labelText: "Choose The Area",
                  hintText: "Area",
                ),
                popupItemDisabled: isItemDisabled,
                onChanged: itemSelectionChangedgetArea,
                selectedItem: selectedarea,
                showSearchBox: true,
                searchFieldProps: const TextFieldProps(
                  cursorColor: Colors.blue,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 100.0),
                      bottom: Radius.elliptical(
                          MediaQuery.of(context).size.width, 100.0)),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Solat Time"),
                    const Icon(
                      Icons.timelapse,
                      size: 64,
                    ),
                    Text(
                      dataOne ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataTwo ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataThree ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataFour ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataFive ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataSix ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      dataSeven ?? '',
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                // color: Colors.grey[100],
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: rowcount,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Material(
                        color: Colors.blue[100],
                        elevation: 8,
                        child: InkWell(
                            highlightColor: Colors.yellow.withOpacity(0.3),
                            splashColor: Colors.red.withOpacity(0.5),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const qblahDirection()),
                              );
                            },
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: const <Widget>[
                                SizedBox(height: 40),
                                Text(
                                  "Qiblat",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Center(
                                    child: Icon(
                                  Icons.arrow_circle_up,
                                  size: 80,
                                )),
                              ],
                            )),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  bool isItemDisabled(String s) {
    //return s.startsWith('I');

    if (s.startsWith('I')) {
      return true;
    } else {
      return false;
    }
  }

  itemSelectionChanged(String? state) async {
    getArea(state);
    setState(() {
      selectedstate = state;
      selectedarea = null;
      dataOne;
      dataTwo;
      dataThree;
      dataFour;
      dataFive;
      dataSix;
      dataSeven;
    });
    _LArea.clear();
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Updating List"));
    progressDialog.show();
    await Future.delayed(const Duration(seconds: 2));
    progressDialog.dismiss();
  }

  itemSelectionChangedgetArea(String? area) async {
    print("itemSelectionChangedgetArea");
    setState(() {
      selectedarea = area;
    });
    var baseUrl =
        "https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json?negeri=$selectedstate&zon=$selectedarea";

    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Updating Data"));
    progressDialog.show();
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        dataOne =
            jsonData['data']['zon'][0]['waktu_solat'][0]['name'].toUpperCase() +
                ' : ' +
                jsonData['data']['zon'][0]['waktu_solat'][0]['time'];
        dataTwo =
            jsonData['data']['zon'][0]['waktu_solat'][1]['name'].toUpperCase() +
                ' : ' +
                jsonData['data']['zon'][0]['waktu_solat'][1]['time'];
        dataThree =
            jsonData['data']['zon'][0]['waktu_solat'][2]['name'].toUpperCase() +
                ' : ' +
                jsonData['data']['zon'][0]['waktu_solat'][2]['time'];
        dataFour =
            jsonData['data']['zon'][0]['waktu_solat'][3]['name'].toUpperCase() +
                ' : ' +
                jsonData['data']['zon'][0]['waktu_solat'][3]['time'];
        dataFive =
            jsonData['data']['zon'][0]['waktu_solat'][4]['name'].toUpperCase() +
                ' : ' +
                jsonData['data']['zon'][0]['waktu_solat'][04]['time'];
        dataSix =
            jsonData['data']['zon'][0]['waktu_solat'][5]['name'].toUpperCase() +
                ' : ' +
                jsonData['data']['zon'][0]['waktu_solat'][5]['time'];
        dataSeven =
            jsonData['data']['zon'][0]['waktu_solat'][6]['name'].toUpperCase() +
                ' : ' +
                jsonData['data']['zon'][0]['waktu_solat'][6]['time'];
      });
      print(dataOne);
    }
    progressDialog.dismiss();
  }

  Future getState() async {
    var baseUrl = "https://waktu-solat-api.herokuapp.com/api/v1/states.json";

    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Please wait.."),
        title: const Text("Updating List"));
    progressDialog.show();
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        _LStates.clear();
        for (var i = 0; i < jsonData['data']['negeri'].length; i++) {
          _LStates.add(jsonData['data']['negeri'][i].toUpperCase());
        }
      });
    }
    progressDialog.dismiss();
  }

  Future getArea(String? state) async {
    var baseUrl =
        "https://waktu-solat-api.herokuapp.com/api/v1/states.json?negeri=$state";
    print(baseUrl);
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      var jsonDataGetArea = json.decode(response.body);
      setState(() {
        _LArea = [];
        _LArea.clear();

        for (var x = 0;
            x < jsonDataGetArea['data']['negeri']['zon'].length;
            x++) {
          _LArea.add(jsonDataGetArea['data']['negeri']['zon'][x]
              .toString()
              .toUpperCase());
        }
      });
    }
  }
}
