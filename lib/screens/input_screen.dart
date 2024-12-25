import 'dart:convert';

import 'package:bmi_calc/widget/custom_card.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  double? height, width;
  int age = 25;
  int weight = 80;
  double humanHeight = 170;
  int gender = 0;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: height! * 0.85,
      width: width!,
      color: isDarkMode ? Color(0xff141414) : Colors.white,
      child: SingleChildScrollView(
        child: Column(
          spacing: 50,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ageCard(),
                  weightCard(),
                ],
              ),
            ),
            heightCard(),
            genderCard(),
            customButton(isDarkMode ? Colors.white : Colors.black),
          ],
        ),
      ),
    );
  }

  Widget ageCard() {
    return CustomCard(
      height: height! * 0.9,
      width: width!,
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Age (yr)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '$age',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (age > 0) {
                        age--;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.minimize_outlined,
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.only(
                    bottom: 12,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      age++;
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget weightCard() {
    return CustomCard(
      height: height! * 0.9,
      width: width!,
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Weight (kg)',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '$weight',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (weight > 10) {
                        weight--;
                      }
                    });
                  },
                  icon: Icon(
                    Icons.minimize_outlined,
                    color: Colors.red,
                  ),
                  padding: EdgeInsets.only(
                    bottom: 12,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      weight++;
                    });
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget heightCard() {
    return CustomCard(
      height: MediaQuery.of(context).orientation == Orientation.landscape
          ? height! * 1.5
          : height! * 0.75,
      width: width! * 2.1,
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              'Height (cm)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '${humanHeight.round()}',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Slider(
                activeColor: Colors.grey,
                max: 200,
                min: 0,
                divisions: 400,
                value: humanHeight,
                onChanged: (value) {
                  setState(() {
                    humanHeight = value;
                  });
                }),
          ),
        ],
      ),
    );
  }

  Widget genderCard() {
    return CustomCard(
      height: MediaQuery.of(context).orientation == Orientation.landscape
          ? height! * 0.75
          : height! * 0.5,
      width: width! * 2.1,
      child: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                'Gender',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            CupertinoSlidingSegmentedControl(
              groupValue: gender,
              children: {
                0: Text(
                  'Male',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                1: Text(
                  'Female',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              },
              onValueChanged: (value) {
                setState(
                  () {
                    gender = value as int;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customButton(Color color) {
    return ElevatedButton(
      onPressed: () {
        showBMIDialog();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(200, 50),
        backgroundColor: Colors.grey,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
      child: Text(
        'Calculate BMI',
        style: TextStyle(color: color),
      ),
    );
  }

  void showDialog(double bmi) {
    String? status;
    if (bmi < 18.5) {
      status = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      status = 'Normal';
    } else if (bmi >= 25 && bmi < 30) {
      status = 'Overweight';
    } else if (bmi >= 30) {
      status = 'Obese';
    }
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(status!),
          content: Text(
            bmi.toStringAsFixed(2),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text(
                'OK',
              ),
              onPressed: () {
                saveResult(bmi.toString(), status!);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  double calculateBMI(double heightInCm, int weight) {
    double heightInMeters = heightInCm / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  String getBMIStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  void showBMIDialog() {
    double bmi = calculateBMI(humanHeight, weight);
    String status = getBMIStatus(bmi);

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(status),
          content: Text(
            'BMI: ${bmi.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                saveResult(bmi.toString(), status);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void saveResult(String bmi, String status) async {
    final prefs = await SharedPreferences.getInstance();
    String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
    String formattedBmi = double.parse(bmi).toStringAsFixed(2);

    String key = 'bmi_${DateTime.now().millisecondsSinceEpoch}';

   
    Map<String, String> result = {
      'bmi': formattedBmi,
      'status': status,
      'date': formattedDate.toString(),
    };

    prefs.setString(key, jsonEncode(result));
  }
}
