import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Symptom extends StatelessWidget {
  final imgUrl, symptom;
  Symptom({this.imgUrl, this.symptom});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7),
      width: MediaQuery.of(context).size.width* .37,
      //height: 140,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xff9BC1BC)),
      child: Column(
        children: [
          ClipRRect(
            child: Image.asset(imgUrl),
            borderRadius: BorderRadius.circular(50),
          ),
          SizedBox(
            height: 7,
          ),
          Text(symptom, style: TextStyle(
            fontStyle: FontStyle.italic
          ) , textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}
