import 'package:covid_tracker/views/LocationSearch.dart';
import 'package:covid_tracker/views/Home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff5CA4A9),
        primarySwatch: Colors.orange,
      ),

      // initialRoute: '/loading',
      routes: {
        '/': (context) => LocationSearch(),
        '/home': (context) => Home()
      },
    );
  }
}
