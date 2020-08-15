import 'package:covid_tracker/controllers/Search.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
   Map cStats = {};

   String worldStats;

   String countryStats;

  @override
  Widget build(BuildContext context) {
   cStats =  cStats.isNotEmpty ? cStats : ModalRoute.of(context).settings.arguments;
   worldStats = cStats['worldStat'];
   countryStats = cStats['countryStat'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        actions: <Widget>[
          FlatButton.icon(
            label: Text('Search country'),
            icon: Icon(Icons.search), onPressed: (){
            showSearch(context: context, delegate:Search());
                      })
                    ],
      ),

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/bg.jpg')),         
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  RefreshIndicator(onRefresh: (){
                    Navigator.pushNamed(context, '/loading', arguments: Search().selectedResult);
                    return null;
                  },
                                  child: Container(
                      padding: EdgeInsets.all(5), 
                      height: MediaQuery.of(context).size.height * .3,               
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(child: Text('Worldwide Count'),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                          ),),
                          SizedBox(
                            height: 15,
                          ),
                          Text('125 M', style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,

                          ),),
                        ],
                      ),
                    ),
                  ), //Worlwide Stats
                  SizedBox(width: 15),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: MediaQuery.of(context).size.height * .2,               
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                          color: Colors.orangeAccent,),
                          child: Text('Countrywide Count', textAlign: TextAlign.center)),
                        SizedBox(
                          height: 15,
                        ),
                        Text('12 M', style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),),
                      ],
                    ),
                  ), //CountryWide
                ],
              ),
            ),
             //Cards To Display Stats, Country, Flag
            Column(
              children: <Widget>[
                Text('Symptoms'),
                SizedBox(height:15),
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
                      //Symptom 1
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                        
                      ),
                      child: Card(
                        elevation: 3,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Icon(Icons.headset_mic),
                          title: Text('First Symptom'),
                          subtitle: Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        
                        ) ,
                        
                      ),
                    ), 
                    Container(
                      //Symptom 2
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                        
                      ),
                      child: Card(
                        elevation: 3,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Icon(Icons.headset_mic),
                          title: Text('Second Symptom'),
                          subtitle: Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        
                        ) ,
                        
                      ),
                    ), 
                    Container(
                      //Symptom 3
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                        
                      ),
                      child: Card(
                        elevation: 3,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Icon(Icons.headset_mic),
                          title: Text('Third Symptom'),
                          subtitle: Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        
                        ) ,
                        
                      ),
                    ), 
                    Container(
                      //Symptom 4
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                        
                      ),
                      child: Card(
                        elevation: 3,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Icon(Icons.headset_mic),
                          title: Text('Fourth Symptom'),
                          subtitle: Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        
                        ) ,
                        
                      ),
                    ), 
                    


                  ],
                ), 

                ),
              ],
            ), //Symptoms slideshow

            //START OF MEASURES
            Column(
              children: <Widget>[
                Text('Measures'),
                SizedBox(height: 15),
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
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                        
                      ),
                      child: Card(
                        elevation: 3,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Icon(Icons.headset_mic),
                          title: Text('Fisrt Measure'),
                          subtitle: Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        
                        ) ,
                        
                      ),
                    ), 
                    Container(
                      
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                        
                      ),
                      child: Card(
                        elevation: 3,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Icon(Icons.headset_mic),
                          title: Text('Second Measure'),
                          subtitle: Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        
                        ) ,
                        
                      ),
                    ), 
                    Container(
                      
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                        
                      ),
                      child: Card(
                        elevation: 3,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Icon(Icons.headset_mic),
                          title: Text('Third Measure'),
                          subtitle: Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        
                        ) ,
                        
                      ),
                    ), 
                    Container(
                      //Symptom 1
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.lightGreen
                        
                      ),
                      child: Card(
                        elevation: 3,
                        color: Colors.black26,
                        child: ListTile(
                          leading: Icon(Icons.headset_mic),
                          title: Text('Fourth Measure'),
                          subtitle: Text('Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'),
                        
                        ) ,
                        
                      ),
                    ), 
                    


                  ],
                ), 

                ),
              ],
            ), //Measures slideshow
          ],
        )
      ),

   
    );
  }
}