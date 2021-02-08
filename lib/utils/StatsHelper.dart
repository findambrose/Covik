import 'package:dio/dio.dart';

class StatsHelper {
  Dio dio;
  Future<Map<String, dynamic>> getStats(String countryName) async {
    Map<String, dynamic> allStats;
    Map<String, dynamic> countryStats;
    Map<String, dynamic> worldStats;

    var url = "https://disease.sh/v3/covid-19/countries/$countryName";
    dio = Dio();
    await dio.get(url).then((response) {
      var countryResponse = response.data;
      print("Cases Today::" + countryResponse['todayCases']);
      print("All time Cases::" + countryResponse['todayCases']);
      print("Deaths Today::" + countryResponse['todayDeaths']);
      print("Recovered::" + countryResponse['todayRecovered']);

      countryStats = {'countryStat': countryResponse,
      'error': ""};
    }).catchError((e) {
      countryStats = {'countryStat': "",
      'error': e.message};
      print("An error Country Stats...world" + e.message);
    });

    await dio.get('https://disease.sh/v3/covid-19/all').then((response) {
      print("Cases Today::" + response.data['todayCases'].toString());
      print("Cases Deaths::" + response.data['todayDeaths'].toString());
      print("Cases Recovered::" + response.data['todayRecovered'].toString());
      worldStats = {
        'stats': response.data,
        'error': ""
      };
    }).catchError((e) {
      worldStats = {
        'stats': "",
        'error': e.message
      };
      print("Error fetching WorldStats" + e.message);
    });


    if(countryStats != null || worldStats != null){
        allStats = {'worldStats': worldStats,
    'countryStats': countryStats};

    }
   
    return allStats;
  }
}
