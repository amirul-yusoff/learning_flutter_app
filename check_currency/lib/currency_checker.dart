import 'dart:convert';

import 'package:check_currency/CurrencyDisplay.dart';
import 'package:check_currency/currency_field.dart';
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
  var currency = "";
  var value = "";
  var date = "";
  var one = 0.0, two = 0.0, three = 0.0, four = 0.0, five = 0.0;
  CurrencyField currentCurrency = CurrencyField("", "", "");
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
              flex: 2,
              child: Image.asset('assets/images/amirul_mobile.png', scale: 2),
            ),
            Flexible(
                flex: 8,
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
                        const SizedBox(height: 20),
                        Text(
                          "The currency is " + currency,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Currency"),
                              const Icon(
                                Icons.money,
                                size: 64,
                              ),
                              Text(
                                "The currency on " + date,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          color: Colors.blue[100],
                        ),
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
    currency = "this is $selectCurrency";
    setState(() {});
    var string =
        "{USD: 0.223813, BTC: 0.00001, ETH: 0.000123, BNB: 0.000737, DOGE: 2.769286, XRP: 0.586502, BCH: 0.001685, LTC: 0.003733}";
    string = string.replaceAll(RegExp(r'{'), '');
    string = string.replaceAll(RegExp(r'}'), '');
    string = string.replaceAll(RegExp(r', '), '\n');
    value = string;
    print(string);
    var apiid = "131b84ba7ab940b7a3187172db51a2fd";
    var url = Uri.parse(
        'https://exchange-rates.abstractapi.com/v1/historical/?api_key=$apiid&base=$selectCurrency&date=2022-08-17');
    var response = await http.get(url);
    var rescode = response.statusCode;
    if (rescode == 200) {
      var jsonData = response.body;
      var parsedJson = json.decode(jsonData);
      setState(() {
        currentCurrency = CurrencyField("", "", "");
        var numbers = parsedJson['exchange_rates'];
        date = parsedJson['date'];
        print(date);
        string = "$numbers";
        string = string.replaceAll(RegExp(r'{'), '');
        string = string.replaceAll(RegExp(r'}'), '');
        string = string.replaceAll(RegExp(r', '), '\n');
        value = string;
        // for (var k in numbers.keys) {
        //   print("$k : ${numbers[k]}");
        // }

        print("here");
        print(parsedJson['exchange_rates'].length);
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
  }
}


//new page
