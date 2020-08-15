import 'package:covid_tracker/models/Country.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  Country selectedResult;
  //Dynamically Generate List
//  var countriesList = List<String>.generate(5, (index){
//     return 'Text $index';
//   });

  var countriesList = [
    Country(name: 'Kenya', flagUrl: '/assets/ke.jpg', searchUrl: '/Africa/Kenya'),
    Country(name: 'Uganda', flagUrl: '/assets/ug.jpg', searchUrl: '/Africa/Uganda'),
    Country(name: 'Tanzania', flagUrl: '/assets/tz.jpg', searchUrl: '/Africa/Tanzania'),
    Country(name: 'Ghana', flagUrl: '/assets/gh.jpg', searchUrl: '/Africa/Ghana'),
  ]; 

  var recentlySearched = [Country(name: 'Kenya', flagUrl: '/assets/ke.jpg', searchUrl: '/Africa/Kenya'),
    Country(name: 'Uganda', flagUrl: '/assets/ug.jpg', searchUrl: '/Africa/Uganda')];
 
  @override
  List<Widget> buildActions(BuildContext context) {
    
    return <Widget>[
      IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    //returns a widget with results to overlap current search window
    return Container(child: Center(
      child: Text(selectedResult.name)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    List<Country> suggestionList = [];

    query.isNotEmpty ? suggestionList
    .addAll(countriesList
    .where((element){
      return element.name.contains(query);
    })) : suggestionList.addAll(recentlySearched) ;
    return ListView.builder(
      itemCount:suggestionList.length,
      itemBuilder: (context, index){
      return ListTile(
        title: Text((suggestionList[index]).name),
        onTap: (){
          //Set suggestion result to selectedResult
            selectedResult = suggestionList[index];
            showResults(context);
            
            //Calculate Stats(Involves sending data to loading page to do calculations) and display results i.e move to home page automatically when results are ready and display results
            //loading page to have getStats method its initState method 
          

        },
      );
    },)  ;
  }
}
