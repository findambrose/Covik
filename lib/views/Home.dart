import 'package:covid_tracker/BloC/LocationSearchBloc.dart';
import 'package:covid_tracker/BloC/StatsBloc.dart';
import 'package:covid_tracker/models/Country.dart';
import 'package:covid_tracker/utils/SharedPrefUtil.dart';
import 'package:covid_tracker/utils/StatsHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream statsStream;
  StatsBloc statsBloc;
  LocationSearchBloc locationSearchBloc;

  @override
  initState() {
    super.initState();
  }

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
  }

  SharedPrefUtil _sharedPrefUtil = new SharedPrefUtil();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        actions: <Widget>[
          TextField(
              decoration: InputDecoration(
                  labelText: "Search Country", hintText: "e.g Kenya"),
              onChanged: (value) {
                locationSearchBloc.behaviorSubject.sink.add(value);
              })
        ],
      ),
      body: StreamBuilder(
        stream: locationSearchBloc.locationStream,
        builder: (context, snapshot){
            if (snapshot.hasData) {
              Map<String, dynamic> data = snapshot.data;
                      if (data['countries'] == "") {
                        return AlertDialog(
                          content:
                              Text('A data error occured:: ${data["error"]}'),
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
                                            
                                                //Fetch dets.. Emit event
                                                statsBloc.controller.sink.add(countries[index].name);


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

          return  StreamBuilder<Object>(
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
                Map<String, dynamic> countryInfo = data['countryStats'];
                Map<String, dynamic> worldInfo = data['worldStats'];

                bool countryError = false;
                bool worldError = false;
                if (countryInfo['error'] == "") {
                  //no error in country stats
                  countryError = true;
                }

                if (worldInfo['error'] == "") {
                  //no error in country stats
                  worldError = true;
                }

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/bg.png'), fit: BoxFit.fill),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Column(
                        children: <Widget>[
                          //Cards To Display Stats, Country, Flag
                          RefreshIndicator(
                            onRefresh: () async {
                              await _sharedPrefUtil.getLocation();
                              var storedLocation =
                                  _sharedPrefUtil.storedUserLocation[0];
                              statsBloc.controller.sink.add(storedLocation);
                            },
                            child: Row(
                              children: <Widget>[
                                //World count
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    height:
                                        MediaQuery.of(context).size.height * .15,
                                    decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text('World Cases Today'),
                                          decoration: BoxDecoration(
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          !worldError
                                              ? worldInfo['stats']['todayCases']
                                              : "Error!.",
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
                                            : "Error!."),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(!worldError
                                            ? 'Deaths:' +
                                                ' ' +
                                                worldInfo['stats']['todayDeaths']
                                            : "Error!."),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                //Countrywide stats
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    height:
                                        MediaQuery.of(context).size.height * .15,
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                            decoration: BoxDecoration(
                                              color: Colors.orangeAccent,
                                            ),
                                            child: Text('Country Cases Today',
                                                textAlign: TextAlign.center)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          countryError
                                              ? 'Today Cases:' +
                                                  ' ' +
                                                  countryInfo['stats']
                                                      ['todayCases']
                                              : "Error!.",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(!countryError
                                            ? 'Recovered:' +
                                                ' ' +
                                                countryInfo['stats']
                                                    ['todaRecovered']
                                            : "Error!."),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(!countryError
                                            ? 'Deaths:' +
                                                ' ' +
                                                countryInfo['stats']
                                                    ['todayDeaths']
                                            : "Error!."),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Symptoms',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 2),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(4),
                                padding: EdgeInsets.all(4),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Container(
                                      //Symptom 1
                                      padding: EdgeInsets.all(5),
                                      width: 50,

                                      //decoration: BoxDecoration(color: Colors.white),

                                      child: ListTile(
                                        leading: SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: Icon(
                                              Icons.headset_mic,
                                              size: 10,
                                            )),
                                        title: Text('First Symptom'),
                                        subtitle: Text(
                                            'Lorem Ipsum has been the industry\'s '),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      //Symptom 2
                                      padding: EdgeInsets.all(5),
                                      decoration:
                                          BoxDecoration(color: Colors.lightGreen),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.black26,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.headset_mic,
                                            size: 10,
                                          ),
                                          title: Text('Second Symptom'),
                                          subtitle: Text(
                                              'Lorem Ipsum has been the industry\'s '),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      //Symptom 3
                                      padding: EdgeInsets.all(5),
                                      decoration:
                                          BoxDecoration(color: Colors.lightGreen),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.black26,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.headset_mic,
                                            size: 10,
                                          ),
                                          title: Text('Third Symptom'),
                                          subtitle: Text(
                                              'Lorem Ipsum has been the industry\'s '),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 50,
                                      //Symptom 4
                                      padding: EdgeInsets.all(5),
                                      decoration:
                                          BoxDecoration(color: Colors.lightGreen),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.black26,
                                        child: ListTile(
                                          leading: Icon(
                                            Icons.headset_mic,
                                            size: 10,
                                          ),
                                          title: Text('Fourth Symptom'),
                                          subtitle: Text(
                                              'Lorem Ipsum has been the industry\'s '),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ), //Symptoms slideshow

                          //START OF MEASURES
                          SizedBox(
                            height: 3,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Measures',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 2),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration:
                                          BoxDecoration(color: Colors.lightGreen),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.black26,
                                        child: ListTile(
                                          leading: Icon(Icons.headset_mic),
                                          title: Text('Fisrt Measure'),
                                          subtitle: Text(
                                              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration:
                                          BoxDecoration(color: Colors.lightGreen),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.black26,
                                        child: ListTile(
                                          leading: Icon(Icons.headset_mic),
                                          title: Text('Second Measure'),
                                          subtitle: Text(
                                              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      decoration:
                                          BoxDecoration(color: Colors.lightGreen),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.black26,
                                        child: ListTile(
                                          leading: Icon(Icons.headset_mic),
                                          title: Text('Third Measure'),
                                          subtitle: Text(
                                              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      //Symptom 1
                                      padding: EdgeInsets.all(5),
                                      decoration:
                                          BoxDecoration(color: Colors.lightGreen),
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.black26,
                                        child: ListTile(
                                          leading: Icon(Icons.headset_mic),
                                          title: Text('Fourth Measure'),
                                          subtitle: Text(
                                              'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ), //Measures slideshow
                        ],
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
}
