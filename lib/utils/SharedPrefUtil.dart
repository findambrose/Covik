import 'package:covid_tracker/models/Country.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil{
  //Todo: Write shared util code
  SharedPreferences sharedPreferences;
  // String sharedPrefName = 'covik'; Not used
  String sLocationKey  = 'userLocation';
  List storedUserLocation;

  static bool isLocationSaved;

 SharedPrefUtil();

 //save into slocation 
 Future<void> saveLocation(Country location) async{
   sharedPreferences = await SharedPreferences.getInstance();
   sharedPreferences.setStringList(sLocationKey, [location.name, location.flagUrl, location.searchUrl]);
 }
   Future<void> getLocation() async{
   sharedPreferences = await SharedPreferences.getInstance();
   storedUserLocation = sharedPreferences.getStringList(sLocationKey);  
 }

  Future<void> checkIfKeyExists()async {
    sharedPreferences = await SharedPreferences.getInstance();
    isLocationSaved = sharedPreferences.containsKey(sLocationKey);   
  }

}