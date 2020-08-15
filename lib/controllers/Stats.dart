import 'package:covid_tracker/models/Country.dart';
import 'package:dio/dio.dart';
class Stats{

  //What i'll get
  String countryStat; 
  String worldStat; 
 
  //what i'll need
  Country location;
  String flag;

  Stats({this.location, this.flag});
  


  //function 
  Future<void> getStatsByCountry() async{

   try {
    Dio dio = new Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    print(response.data.body.toString());
  } catch (e) {
    print('Error Caught:' + e);
    countryStat = 'Count not found, try reloading the page';

  } 
   
  }

   Future<void> getWorldStats() async{

    //1. code to get time from api and set it
    //2. 
  try {
    Dio dio = new Dio();
    Response response = await dio.get('https://jsonplaceholder.typicode.com/posts/1');
    print(response.data);
  } catch (e) {
    print('Error Caught' + e);
    worldStat = 'Stat not found, try reloading the page';

  }   
   
  }

}