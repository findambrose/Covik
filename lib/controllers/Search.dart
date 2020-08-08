import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  String selectedResult;
  //Dynamically Generate List
//  var countriesList = List<String>.generate(5, (index){
//     return 'Text $index';
//   });

  var countriesList = [
    'Kenya',
    'Uganda',
    'Tanzania',
    'Ghana'
  ]; 

  var recentlySearched = ['Uganda', 'Kenya'];
 
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
    
    return Container(child: Center(child: Text(selectedResult)));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
    List<String> suggestionList = [];

    !query.isEmpty ? suggestionList
    .addAll(countriesList
    .where((element){
      return element.contains(query);
    })) : suggestionList.addAll(recentlySearched) ;
    return ListView.builder(
      itemCount:suggestionList.length,
      itemBuilder: (context, index){
      return ListTile(
        title: Text(suggestionList[index]),
        onTap: (){
          //Set suggestion result to selectedResult
        
            selectedResult = suggestionList[index];
            showResults(context);
          
          

        },
      );
    },)  ;
  }
}
