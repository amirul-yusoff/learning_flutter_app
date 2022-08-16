import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class BmiCalcPage extends StatefulWidget {
  const BmiCalcPage({Key? key}) : super(key: key);
  @override
  State<BmiCalcPage> createState() => _BmiCalcPageState();
}

class _BmiCalcPageState extends State<BmiCalcPage> {
  TextEditingController heighttextEditingController = TextEditingController();
  TextEditingController weighttextEditingController = TextEditingController();
  double height = 0.0, weight = 0.0, bmi = 0.0;
  AudioCache audioCache = new AudioCache();
  AudioPlayer audioPlayer = new AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('BMI Calculator'),
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Flexible(
                  flex: 4,
                  child:
                      Image.asset('assets/images/Screenshot_2.png', scale: 1)),
              Flexible(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            "BMI Calculator",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: heighttextEditingController,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "Height in Metres",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: weighttextEditingController,
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "Weight in Kilograms",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0))),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: _calBMI,
                              child: const Text("Calculate BMI")),
                          const SizedBox(height: 20),
                          Text(
                            "your BMI is " + bmi.toStringAsPrecision(3),
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }

  void _calBMI() {
    height = double.parse(heighttextEditingController.text);
    weight = double.parse(weighttextEditingController.text);
    setState(() {
      bmi = weight / (height * height);
      if (bmi > 25) {
        loadFail();
      } else if ((bmi <= 24.9) && (bmi >= 18.5)) {
        loadOk();
      } else if (bmi < 18.5) {
        loadFail();
      }
    });

    print("_calBMI");
    print(bmi);
  }

  Future loadOk() async {
    audioPlayer = await AudioCache().play("audios/ok.m4a");
  }

  Future loadFail() async {
    audioPlayer = await AudioCache().play("audios/fail.m4a");
  }
}
