import 'package:covid_tracker/BloC/LocationSearchBloc.dart';
import 'package:covid_tracker/models/Country.dart';
import 'package:covid_tracker/utils/SearchHelper.dart';
import 'package:covid_tracker/utils/SharedPrefUtil.dart';
import 'package:flutter/material.dart';

class LocationSearch extends StatelessWidget {
  final searchBloc = LocationSearchBloc(SearchHelper());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9BC1BC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3),
                Text("Type in a country name to search",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic)),
                SizedBox(height: 8),
                Container(
                  height: 40,
                  margin: EdgeInsets.all(7),
                  child: TextFormField(
                    onChanged: (value) {
                      searchBloc.behaviorSubject.sink.add(value);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: 2.5, left: 10),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: Color(0xffED6A5A),
                            )),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Color(0xffF4F1BB))),
                        labelText: "Search",
                        hintText: "Start typing.. e.g. Kenya"),
                  ),
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
                            content: Text(
                                'An data error occured:: ${data["error"]}'),
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
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: countries.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, right: 4.0),
                                    //  height: 5,
                                    child: Column(
                                      children: [
                                        FlatButton(
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.transparent,
                                          child: Text(countries[index].name),
                                          onPressed: () {
                                            //Save to shared prefs
                                            SharedPrefUtil sharedPrefUtil =
                                                SharedPrefUtil();
                                            Country country = Country(
                                              flagUrl: "",
                                              name: countries[index].name,
                                              searchUrl: countries[index]
                                                  .name
                                                  .toLowerCase(),
                                            );

                                            sharedPrefUtil
                                                .saveLocation(country);
                                            //Move to next screen with country details
                                            Country countryDetails = Country(
                                                flagUrl: "",
                                                name: countries[index].name,
                                                searchUrl: countries[index]
                                                    .name
                                                    .toLowerCase());
                                            Navigator.pushNamed(
                                                context, '/home', arguments: {
                                              'countryDets': countryDetails
                                            });
                                          },
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: Color(0xff5CA4A9)),
                                            height: .5)
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }
                      }
                      return Container();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
