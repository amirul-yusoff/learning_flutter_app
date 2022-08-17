import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_application/weather.dart';
import 'package:ndialog/ndialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Material App Bar'),
          ),
          body: const HomePage()),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var temp = 0.0, hum = 0, desc = "No records", weather = "", description = "";
  Weather currentweather = Weather("Not Available", 0.0, 0, "Not Available");
  String selectLoc = "Changlun";
  List<String> locList = [
    "Changlun",
    "Jitra",
    "Alor Setar",
    "Cheras",
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Simple Wheather App",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            itemHeight: 60,
            value: selectLoc,
            onChanged: (newValue) {
              setState(() {
                selectLoc = newValue.toString();
              });
            },
            items: locList.map((selectLoc) {
              return DropdownMenuItem(
                child: Text(
                  selectLoc,
                ),
                value: selectLoc,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: _loadWeather, child: const Text("Load Weather")),
          Expanded(
            child: Weathergrid(
              currentweather: currentweather,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _loadWeather() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();
    var apiid = "55f074652e515c56391b48e51250528f";
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$selectLoc&appid=$apiid&units=metric');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        temp = parsedJson['main']['temp'];
        hum = parsedJson['main']['humidity'];
        weather = parsedJson['weather'][0]['main'];
        description = parsedJson['weather'][0]['description'];
        currentweather = Weather(selectLoc, temp, hum, weather);
        desc =
            "The current weather in $selectLoc is $weather. The current temperature is $temp Celcius and humidity is $hum percent. The sky are $description";
      });
      Fluttertoast.showToast(
          msg: "Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {
        desc = "No record";
      });
      Fluttertoast.showToast(
          msg: "Failed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    progressDialog.dismiss();
  }
}

class Weathergrid extends StatefulWidget {
  final Weather currentweather;
  const Weathergrid({Key? key, required this.currentweather}) : super(key: key);

  @override
  State<Weathergrid> createState() => _WeathergridState();
}

class _WeathergridState extends State<Weathergrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Location"),
              const Icon(
                Icons.location_city,
                size: 64,
              ),
              Text(widget.currentweather.loc)
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Weather"),
              const Icon(
                Icons.cloud,
                size: 64,
              ),
              Text(widget.currentweather.weather)
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Temp"),
              const Icon(
                Icons.thermostat,
                size: 64,
              ),
              Text(widget.currentweather.temp.toString() + " Celcius")
            ],
          ),
          color: Colors.blue[100],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Humidity"),
              const Icon(
                Icons.hot_tub,
                size: 64,
              ),
              Text(widget.currentweather.hum.toString() + "%")
            ],
          ),
          color: Colors.blue[100],
        ),
      ],
    );
  }
}
