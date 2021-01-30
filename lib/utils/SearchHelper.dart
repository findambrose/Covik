import 'dart:io';

import 'package:covid_tracker/models/Country.dart';
import 'package:dio/dio.dart';

class SearchHelper{


    Future<List<Country>> searchLocation(String searchTerm) async{    
        //TODO: Call location service
        //Get locations according to search, add to list

        
        List<Country> countries = [];
        Dio dio = Dio();
        await dio.get("URL").then((response){
            var responseBody = response.data;
            // var responseBody = response.data;
             print('Data Fetch success:::');
             print('Data:: $responseBody');
           
        }).catchError((e){
          print('Error Encountered Fecthcing from API.::: ${e.message}');
        });
        

        return countries;

    }  
}