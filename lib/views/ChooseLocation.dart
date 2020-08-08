import 'package:covid_tracker/controllers/Search.dart';
import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  var _defaultValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Choose Location'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate:Search());
                      })
                    ],
                  ),
            
                  body: Container(
                   padding: EdgeInsets.all(10),
                   child: Column(
                     children: <Widget>[
                       Text('Click to choose your location'),
                       SizedBox(height: 10),
                       DropdownButton(
                         value: _defaultValue,//default value
                         items: [
                         DropdownMenuItem(child: Text('Kenya'), value: 1),
                         DropdownMenuItem(child: Text('Uganda'), value: 1),
                         DropdownMenuItem(child: Text('Tanzania'), value: 1),
                         DropdownMenuItem(child: Text('Ghana'), value: 1),
            
                       ], onChanged: (value){
            
                         //1.
                         setState((){
                           _defaultValue = value;
                         });
            
                        //2. Calculate time(call async function) and send it to Homepage I'll go withis
                        //OR
                        //Send location to Homepage so location can eb calculated
                       })
                     ],
                   ),
                  ),
            
               
                );
              }
            }
