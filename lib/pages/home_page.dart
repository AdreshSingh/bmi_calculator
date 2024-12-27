import 'dart:math';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // geneder selection
  String _selected = "male";
  final gender = "gender";

  // input fields
  final weightController = TextEditingController();
  final heightController = TextEditingController();

  // BMI both result
  double metric = 0;
  double standard = 0;

  // BMI selection
  int _chipValue = 1;

  // string msg
  String bmiStatus = "";
  @override
  Widget build(BuildContext context) {
    // var width = MediaQuery.of(context).size.width * .6;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          // geneder selection
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: RadioListTile<String>(
                  title: const Text("Male"),
                  value: "male",
                  groupValue: _selected,
                  onChanged: (choice) {
                    setState(() {
                      _selected = choice!;
                    });
                    debugPrint(_selected);
                  },
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: RadioListTile(
                  title: const Text("Female"),
                  value: "female",
                  groupValue: _selected,
                  onChanged: (choice) {
                    setState(() {
                      _selected = choice!;
                    });
                    debugPrint(_selected);
                  },
                ),
              ),
            ],
          ),
          // BMI type
          Row(
            children: [
              ChoiceChip(
                label: const Text("Metric"),
                selected: _chipValue == 1,
                onSelected: (value) {
                  setState(() {
                    _chipValue = value ? 1 : 2;
                  });
                },
              ),
              const SizedBox(
                width: 20,
              ),
              ChoiceChip(
                label: const Text("Imperial"),
                selected: _chipValue == 2,
                onSelected: (value) {
                  setState(() {
                    _chipValue = value ? 2 : 1;
                  });
                },
              )
            ],
          ),

          const SizedBox(
            height: 30,
          ),
          // wieght
          TextField(
            controller: weightController,
            decoration: InputDecoration(
              hintText: "weight(kg)",
              label: const Text("Weight"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(
            height: 15,
          ),
          // height
          TextField(
            controller: heightController,
            decoration: InputDecoration(
              hintText: "height(cm)",
              label: const Text("Height"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // bmit button
          ElevatedButton(
            onPressed: () {
              convert();
            },
            child: const Text("Convert"),
          ),

          const SizedBox(
            height: 50,
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _chipValue == 1
                            ? "METRIC: ${metric.round()}"
                            : "STANDARD: ${metric.round()}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 26,
                        ),
                      ),
                      Text(
                        bmiStatus,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),

          // dividing the line into 4 parts
          // LinearProgressIndicator(
          //   value: metric / 40,
          // )
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                height: 50, // Chart height based on BMI
                width: metric * 10,
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    metric.toStringAsFixed(1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void convert() {
    double wieght = double.parse(weightController.value.text);
    double height = double.parse(heightController.value.text);

    setState(() {
      if (_chipValue == 1) {
        metric = wieght / pow((height / 100), 2);
      } else {
        metric = (wieght / pow((height / 100), 2)) * 703;
      }

      if (metric < 18.5) {
        bmiStatus = "Under weight";
      } else if (metric >= 18.5 && metric < 24.9) {
        bmiStatus = "Normal Weight";
      } else if (metric >= 18.5 && metric < 24.9) {
        bmiStatus = "Over Weight";
      } else if (metric >= 30) {
        bmiStatus = "Obese";
      }
    });
  }
}
