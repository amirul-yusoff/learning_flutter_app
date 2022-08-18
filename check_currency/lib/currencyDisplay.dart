import 'package:check_currency/currency_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyDisplay extends StatefulWidget {
  final CurrencyField currentCurrency;

  const CurrencyDisplay({Key? key, required this.currentCurrency})
      : super(key: key);

  @override
  State<CurrencyDisplay> createState() => _CurrencyDisplayState();
}

class _CurrencyDisplayState extends State<CurrencyDisplay> {
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
              const Text("Weather"),
              const Icon(
                Icons.cloud,
                size: 64,
              ),
            ],
          ),
          color: Colors.blue[100],
        ),
      ],
    );
  }
}
