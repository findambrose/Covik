
import 'package:covid_tracker/models/Country.dart';
import 'package:dio/dio.dart';

class SearchHelper{

   Dio dio;
    Future<Map<String, dynamic>> searchLocation(String searchTerm) async{

      Map<String, dynamic> data;
     dio = Dio();
     String url = "https://restcountries.eu/rest/v2/name/$searchTerm";
        await dio.get(url).then((response){
            var responseBody = response.data;
            List<Country> countries = [];
            for (var country in responseBody) {
              Country myCountry = Country(name: country["name"].toString(), flagUrl: country["flag"].toString());
              countries.add(myCountry);
              data = {'countries': countries};
            }
            // var responseBody = response.data;
             print('Data Fetch success:::');
             print('Data:: $responseBody');
             countries.forEach((element) {print(element);});
           
        }).catchError((e){
          print('Error Encountered Fecthcing from API.::: ${e.message}');

          data = {'countries': "",
          'error': e.message};
        });
        

        return data;

    }  
}