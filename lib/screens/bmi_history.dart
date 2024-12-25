import 'dart:convert'; // Required for JSON encoding/decoding.
import 'package:bmi_calc/widget/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class BmiHistory extends StatelessWidget {
  BmiHistory({super.key});

  double? height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.sizeOf(context).height;
    width = MediaQuery.sizeOf(context).width;
    return dataCard();
  }

  Widget dataCard() {
    return FutureBuilder(
      future: getResults(),
      builder: (BuildContext context, AsyncSnapshot<List<Map<String, String>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(
              color: Colors.blue,
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No BMI records found!',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        
        final results = snapshot.data!;
        final latestResult = results.last;

        return Center(
          child: CustomCard(
            height: height! * 2,
            width: width! * 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                status(latestResult['status'] ?? 'Unknown'),
                lastTimeData(latestResult['date'] ?? 'Unknown'),
                bmi(latestResult['bmi'] ?? '0.0'),
              ],
            ),
          ),
        );
      },
    );
  }

}

  Widget status(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 35,
      ),
    );
  }

  Widget lastTimeData(String date) {
    return Text(
      date,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }

  Widget bmi(String bmiValue) {
    return Text(
      'BMI: $bmiValue',
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
    );
  }

  Future<List<Map<String, String>>> getResults() async {
    final prefs = await SharedPreferences.getInstance();
    List<Map<String, String>> results = [];

    for (String key in prefs.getKeys()) {
      if (key.startsWith('bmi_')) { 
        String? resultString = prefs.getString(key);
        if (resultString != null) {
          try {
            Map<String, String> result = Map<String, String>.from(jsonDecode(resultString));
            results.add(result);
          } catch (e) {
            print('Error decoding result for key $key: $e');
          }
        }
      }
    }
    return results;
  }
