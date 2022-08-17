import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';

class CurrencyChecker extends StatefulWidget {
  const CurrencyChecker({Key? key}) : super(key: key);

  @override
  State<CurrencyChecker> createState() => _CurrencyCheckerState();
}

class _CurrencyCheckerState extends State<CurrencyChecker> {
  String selectCurrency = "MYR";
  List<String> currencyList = [
    "MYR",
    "EUR",
    "JPY",
    "BGN",
    "CZK",
    "DKK",
    "GBP",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Checker'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Flexible(
              flex: 4,
              child: Image.asset('assets/images/amirul_mobile.png', scale: 2),
            ),
            Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "Please select the Currency",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        DropdownButton(
                          itemHeight: 60,
                          value: selectCurrency,
                          onChanged: (newValue) {
                            setState(() {
                              selectCurrency = newValue.toString();
                            });
                          },
                          items: currencyList.map((selectCurrency) {
                            return DropdownMenuItem(
                              child: Text(
                                selectCurrency,
                              ),
                              value: selectCurrency,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                            onPressed: _loadCurrency,
                            child: const Text("Check Currency")),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Future<void> _loadCurrency() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    var apiid = "131b84ba7ab940b7a3187172db51a2fd";
    var url = Uri.parse(
        'https://exchange-rates.abstractapi.com/v1/historical/?api_key=$apiid&base=$selectCurrency&date=2020-08-31');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      Fluttertoast.showToast(
          msg: "Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      setState(() {});
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
    print(rescode);
  }
}
