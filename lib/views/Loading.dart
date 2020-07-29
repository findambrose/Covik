import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Register'),
      ),

      body: Container(
        child: Center(
         child: Text('Loading page'),
        ),
      ),

   
    );
  }
}