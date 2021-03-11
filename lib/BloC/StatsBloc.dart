import 'package:covid_tracker/utils/StatsHelper.dart';
import 'package:rxdart/rxdart.dart';

import 'Bloc.dart';

class StatsBloc extends Bloc {

  Stream<Map<String, dynamic>> stats = Stream.empty();

  BehaviorSubject<String> controller = BehaviorSubject();


  StatsBloc(StatsHelper statsHelper) {
    stats = controller.distinct().asyncMap(statsHelper.getStats).asBroadcastStream();
  }

  @override
  dispose() {
    
    controller.close();
  
  }

}