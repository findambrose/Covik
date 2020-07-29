import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
      ),

      body: Container(
        child: Center(
          child: Text('Home page, add edit location button. show stats(by country and world wide)'),
          
        ),
      ),

   
    );
  }
}