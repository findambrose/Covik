import 'package:covid_tracker/utils/SearchHelper.dart';
import 'package:rxdart/rxdart.dart';

class LocationSearchBloc{

    Stream<Map<String, dynamic>> locationStream = Stream.empty();
    BehaviorSubject<String> behaviorSubject = BehaviorSubject<String>();

    LocationSearchBloc(SearchHelper searchService){
      
      locationStream = behaviorSubject.distinct().asyncMap(searchService.searchLocation).asBroadcastStream();

    }

}