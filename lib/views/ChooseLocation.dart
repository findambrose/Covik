import 'package:flutter/material.dart';

class ChooseLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Choose Location'),
      ),

      body: Container(
        child: Center(

          child: Text('Display a list of locations, with flags, and name')
        ),
      ),

   
    );
  }
}