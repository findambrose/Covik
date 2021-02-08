import 'package:covid_tracker/utils/StatsHelper.dart';
import 'package:rxdart/rxdart.dart';

class StatsBloc {

  Stream<Map<String, dynamic>> stats = Stream.empty();

  BehaviorSubject<String> controller = BehaviorSubject();


  StatsBloc(StatsHelper statsHelper) {
    stats = controller.distinct().asyncMap(statsHelper.getStats).asBroadcastStream();
  }

}