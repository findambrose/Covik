import 'package:covid_tracker/BloC/LocationSearchBloc.dart';
import 'package:covid_tracker/BloC/StatsBloc.dart';
import 'package:covid_tracker/models/Country.dart';
import 'package:covid_tracker/utils/SearchHelper.dart';
import 'package:covid_tracker/utils/SharedPrefUtil.dart';
import 'package:covid_tracker/utils/StatsHelper.dart';
import 'package:covid_tracker/views/widgets/Prevention.dart';
import 'package:covid_tracker/views/widgets/Symptom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream statsStream;
  StatsBloc statsBloc;
  LocationSearchBloc locationSearchBloc;

  Key key = Key("refreshKey");

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    setUpStats();
  }

  setUpStats() {
    Map<String, dynamic> countryDets =
        ModalRoute.of(context).settings.arguments;
    statsBloc = StatsBloc(StatsHelper());
    statsBloc.controller.sink.add(countryDets['countryDets'].name);
    print("Setup Stats" + countryDets['countryDets'].name);
  }

  SharedPrefUtil _sharedPrefUtil = new SharedPrefUtil();

  @override
  Widget build(BuildContext context) {
    locationSearchBloc = LocationSearchBloc(SearchHelper());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.all(7),
            width: MediaQuery.of(context).size.width * .85,
            child: TextField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 2.5, left: 10),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    filled: true,
                    fillColor: Color(0xffE6EBE0),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xffED6A5A),
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0xffF4F1BB))),
                    hintText: "Start typing country name.. e.g. Kenya"),
                onChanged: (value) {
                  locationSearchBloc.behaviorSubject.sink.add(value);
                }),
          )
        ],
      ),
      body: StreamBuilder(
        //Search Stream Builder
        stream: locationSearchBloc.locationStream,
        builder: (context, snapshot) {
          //Search: Has Error
          if (snapshot.hasError) {
            print("A general error has occured. Reload.");
            return AlertDialog(
              content: Text("A general error has occured. Reload."),
            );
          }

          //Search::: Has data
          if (snapshot.hasData) {
            Map<String, dynamic> data = snapshot.data;
            if (data['countries'] == "") {
              return AlertDialog(
                content: Text('A data error occured:: ${data["error"]}'),
              );
            } else {
              //Search::: Results found. No error

              List<Country> countries = data['countries'];
              countries.forEach((element) {
                print(element.name);
              });

              return Container(
                padding: EdgeInsets.all(8),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
                                FlatButton(
                                  color: Colors.transparent,
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(countries[index].name),
                                  onPressed: () {
                                    //Fetch dets.. Emit event
                                    statsBloc.controller.sink
                                        .add(countries[index].name);

                                    //Hide search results. That is.. Empty data
                                    //data = {};

                                    Country countryDetails = Country(
                                        flagUrl: "",
                                        name: countries[index].name,
                                        searchUrl: countries[index]
                                            .name
                                            .toLowerCase());
                                    Navigator.pushNamed(context, '/home',
                                        arguments: {
                                          'countryDets': countryDetails
                                        });
                                  },
                                ),
                                Container(
                                    decoration:
                                        BoxDecoration(color: Color(0xff5CA4A9)),
                                    height: .5)
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              );
            }
          }

          // Main Content StreamBuilder
          return StreamBuilder<Object>(
              stream: statsBloc.stats,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Container(
                    child: Center(
                        child: AlertDialog(
                      content: Text('An error occured. Try reloading.'),
                    )),
                  );
                }
                if (snapshot.hasData) {
                  //Determine if errors present
                  Map<String, dynamic> data = snapshot.data;
                  print("Data in home view:  $data");
                  Map<String, dynamic> countryInfo = data['countryStats'];
                  Map<String, dynamic> worldInfo = data['worldStats'];
                  bool countryError = false;
                  bool worldError = false;
                  if (countryInfo['error'] != "") {
                    //no error in country stats
                    countryError = true;
                  }
                  if (worldInfo['error'] != "") {
                    //no error in country stats
                    worldError = true;
                  }

                  return Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffE6EBE0),
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.green.withOpacity(.1), BlendMode.dstATop),
                          image: AssetImage('assets/bg.jpg'),
                          fit: BoxFit.cover),
                    ),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await _sharedPrefUtil.getLocation();
                        var storedLocation =
                            _sharedPrefUtil.storedUserLocation[0];
                        statsBloc.controller.sink.add(storedLocation);
                      },
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          padding: EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  //World count
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .16,
                                      decoration: BoxDecoration(
                                          color: Color(0xff9BC1BC),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.all(3),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              'World Cases Today',
                                              textAlign: TextAlign.center,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  topRight: Radius.circular(4)),
                                              color: Color(0xffF4F1BB),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            !worldError
                                                ? worldInfo['stats']
                                                        ['todayCases']
                                                    .toString()
                                                : "",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(!worldError
                                              ? 'Recovered:' +
                                                  ' ' +
                                                  worldInfo['stats']
                                                          ['todayRecovered']
                                                      .toString()
                                              : "Error fetching stats."),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(!worldError
                                              ? 'Deaths: ' +
                                                  worldInfo['stats']
                                                          ['todayDeaths']
                                                      .toString()
                                              : ""),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  //Countrywide stats
                                  Expanded(
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .16,
                                      decoration: BoxDecoration(
                                          color: Color(0xff9BC1BC),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              padding: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    topRight:
                                                        Radius.circular(4)),
                                                color: Color(0xffF4F1BB),
                                              ),
                                              child: Text('Country Cases Today',
                                                  textAlign: TextAlign.center)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            !countryError
                                                ? 'Today Cases:' +
                                                    ' ' +
                                                    countryInfo['countryStat']
                                                            ['todayCases']
                                                        .toString()
                                                : "",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            !countryError
                                                ? 'Recovered:' +
                                                    ' ' +
                                                    countryInfo['countryStat']
                                                            ['todayRecovered']
                                                        .toString()
                                                : "Error fetching stats.",
                                            style: TextStyle(
                                              color: !countryError
                                                  ? Colors.white
                                                  :  Color(0xffED6A5A),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(!countryError
                                              ? 'Deaths:' +
                                                  ' ' +
                                                  countryInfo['countryStat']
                                                          ['todayDeaths']
                                                      .toString()
                                              : ""),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              //Symptoms
                              SizedBox(height: 15),
                              Text(
                                "Symptoms",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xffED6A5A),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3),
                              SizedBox(
                                height: 150,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Symptom(
                                        imgUrl: "assets/fever.jpg",
                                        symptom: "FEVER"),
                                    Symptom(
                                        imgUrl: "assets/chills.jpg",
                                        symptom: "CHILLS"),
                                    Symptom(
                                        imgUrl: "assets/breath.jpg",
                                        symptom: "SHORTNESS OF BREATH"),
                                    Symptom(
                                        imgUrl: "assets/throat.jpg",
                                        symptom: "SORE THROAT"),
                                    Symptom(
                                        imgUrl: "assets/fatigue.jpg",
                                        symptom: "FATIGUE"),
                                    Symptom(
                                        imgUrl: "assets/aches.jpg",
                                        symptom: "ACHES"),
                                    Symptom(
                                        imgUrl: "assets/congestion.jpg",
                                        symptom: "CONGESTION"),
                                    Symptom(
                                        imgUrl: "assets/sense.jpg",
                                        symptom: "LOSS OF SENSE OF SMELL"),
                                    Symptom(
                                        imgUrl: "assets/nausea.jpg",
                                        symptom: "NAUSEA"),
                                    Symptom(
                                        imgUrl: "assets/diarrhoea.jpg",
                                        symptom: "DIARRHOEA"),
                                    Symptom(
                                        imgUrl: "assets/rashes.jpg",
                                        symptom:
                                            "RASHES AND INFLAMATION, ESPECIALLY IN KIDS")
                                  ],
                                ),
                              ),

                              SizedBox(height: 15),
                              //Prevention
                              Text(
                                "Prevention",
                                style: TextStyle(
                                    color: Color(0xffED6A5A),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 3),
                              SizedBox(
                                height: 205,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Prevention(
                                      imgUrl: "assets/wash.jpg",
                                      symptom:
                                          "Wash your hands regularly with soap and water",
                                    ),
                                    Prevention(
                                        imgUrl: "assets/touch.jpg",
                                        symptom:
                                            "  Avoid touching your eyes, nose or mouth"),
                                    Prevention(
                                        imgUrl: "assets/cover.jpg",
                                        symptom:
                                            "Cover your mouth or nose when coughing or sneezing"),
                                    Prevention(
                                        imgUrl: "assets/disposable.jpg",
                                        symptom:
                                            "Use only disposable tissues, and dispose of them immediately after use"),
                                    Prevention(
                                        imgUrl: "assets/contact.jpg",
                                        symptom:
                                            "Avoid close contact with anyone showing respiratory symptoms"),
                                    Prevention(
                                        imgUrl: "assets/travel.jpg",
                                        symptom:
                                            "Monitor travel advice on Smartraveller smartraveller.gov.au"),
                                    Prevention(
                                        imgUrl: "assets/home.jpg",
                                        symptom: "Say at home when you're sick")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container(
                  child: SpinKitChasingDots(
                    color: Colors.purpleAccent,
                  ),
                );
              });
        },
      ),
    );
  }

  // bool _notifacationPredicate(ScrollNotification notification) {
  //   return true;
  // }
}
