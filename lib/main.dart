import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/input_page.dart';
import 'physical_data.dart';

void main() {
  runApp(ChangeNotifierProvider<PhysicalData>(
    create: (context) => PhysicalData(),
    child: BMICalculator(),
  ));
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF0A0E21),
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: InputPage(),
    );
  }
}
