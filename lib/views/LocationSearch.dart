import 'package:covid_tracker/BloC/LocationSearchBloc.dart';
import 'package:covid_tracker/models/Country.dart';
import 'package:covid_tracker/utils/SearchHelper.dart';
import 'package:flutter/material.dart';

class FlashPage extends StatelessWidget {
  final searchBloc = LocationSearchBloc(SearchHelper());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("Type in your location to search"),
              SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  searchBloc.behaviorSubject.sink.add(value);
                },
                decoration: InputDecoration(
                    labelText: "Search", hintText: "e.g. Kenya"),
              ),
              SizedBox(height: 10),
              //Search Results
              StreamBuilder(
                  stream: searchBloc.locationStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      print("A general error has occured. Reload.");
                      return AlertDialog(
                        content: Text("A general error has occured. Reload."),
                      );
                    }

                     if (snapshot.connectionState == ConnectionState.active) {
                      print("Connected. Loadig countries");
                      return CircularProgressIndicator(
                        
                      );
                    }

                     if (snapshot.hasData) {

                       List<Country> countries = snapshot.data;
                      print("No General Error. Data Error Might Have Occured Tho. Data  is ${countries.toString()}");
                      return Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)
                        ),

                        child:  SingleChildScrollView(
                          child: ListView.builder(
                          
                          itemCount: countries.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(countries[index].name),
                            );

                        }),
                        )
                      );
                    }
                    return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
