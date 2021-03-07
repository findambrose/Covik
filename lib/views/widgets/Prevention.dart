import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Prevention extends StatelessWidget {
  final imgUrl, symptom;
  Prevention({this.imgUrl, this.symptom});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      width: MediaQuery.of(context).size.width*.37,
      //height: 220,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff9BC1BC)),
      child: Column(
        children: [
          ClipRRect(
            child: Image.asset(imgUrl),
            borderRadius: BorderRadius.circular(20)
          ),
          SizedBox(
            height: 5,
          ),
         Text(symptom, textAlign: TextAlign.center, style: TextStyle(
            fontStyle: FontStyle.italic
         ),)
        ],
      ),
    );
  }
}
