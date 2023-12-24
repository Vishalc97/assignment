
import 'package:calenderselection/Screens/MyCalender.dart';
import 'package:calenderselection/utilities/GlobalUtilities.dart';
import 'package:flutter/material.dart';

void main() {

  getJsonResponse();
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Calender',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyCalender(),
    );
  }
}


