import 'package:covid_tracker/BloC/LocationSearchBloc.dart';
import 'package:covid_tracker/models/Country.dart';
import 'package:covid_tracker/utils/SearchHelper.dart';
import 'package:covid_tracker/utils/SharedPrefUtil.dart';
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

                    if (snapshot.hasData) {
                      Map<String, dynamic> data = snapshot.data;
                      if (data['countries'] == "") {
                        return AlertDialog(
                          content:
                              Text('An data error occured:: ${data["error"]}'),
                        );
                      } else {
                        List<Country> countries = data['countries'];
                        countries.forEach((element) {
                          print(element.name);
                        });
                        return Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: countries.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(

                                        child: Column(
                                          children: [
                                            SizedBox(height: 2,),
                                            FlatButton(
                                              color: Colors.white,
                                      child: Text(countries[index].name),
                                              onPressed: (){
                                                //Save to shared prefs
                                                SharedPrefUtil sharedPrefUtil =  SharedPrefUtil();
                                                Country country = Country(flagUrl: "", name: countries[index].name, searchUrl: countries[index].name.toLowerCase(),  );
                                                
                                                sharedPrefUtil.saveLocation(country);
                                                //Move to next screen with country details
                                                Country countryDetails = Country(flagUrl: "", name: countries[index].name, searchUrl: countries[index].name.toLowerCase());
                                                Navigator.pushNamed(context, '/home', arguments: {
                                                  'countryDets': countryDetails
                                                });


                                              },
                                    ),
                                            SizedBox(height: 4,),
                                            Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.purple
                                                ),
                                                height:2)
                                          ],
                                        ),

                                    ),
                                  );
                                }),
                          ),
                        );
                      }
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
