import 'package:flutter/material.dart';

class FlashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      
      body: Container(
        
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg.png'),
          fit: BoxFit.fill,
        ),

      ),
          child: Center(
            child: Column(
              children: <Widget>[
                Text('Welcome to Covik', 
                style: TextStyle(fontSize: 40),),
                SizedBox(height: 15),
                Text('Valid Information | Statistics | Track', 
                ),
              ],
            ),
          )
    ),
    );
  }
}