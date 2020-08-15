import 'package:covid_tracker/controllers/Stats.dart';
import 'package:covid_tracker/models/Country.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Map _selectedCountry = {};
  @override
  void initState() {
    super.initState(); 
    setUpStats();
     
  }

  void setUpStats() async {
    _selectedCountry = _selectedCountry.isNotEmpty ? _selectedCountry : ModalRoute.of(context).settings.arguments;
    final Country country = Country(searchUrl: _selectedCountry['searchUrl'], flagUrl: _selectedCountry['flagUrl'], name: _selectedCountry['name']);
    Stats stats = Stats(location: country);
    await stats.getStatsByCountry();
    await stats.getWorldStats();
    Navigator.pushReplacementNamed(context, '/home', arguments: stats);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(    
      body: SafeArea(
              child: Container(         
           child:   SpinKitRotatingCircle(
                    color: Colors.green,
                    size: 50.0, 
            ),
        ),
      ),

   
    );
  }
}