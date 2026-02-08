import 'package:hive/hive.dart';
import 'package:riverpod_clean_architecture/features/trip/data/models/trip_model.dart';

class TripLocalDatasource {
  final Box<TripModel> tripBox;

  TripLocalDatasource(this.tripBox);

  List<TripModel> getTrips(){
    return tripBox.values.toList();
  }

  void addTrip(TripModel trip){
    tripBox.add(trip);
  }

  void deleteTrip(int index){
    tripBox.deleteAt(index);
  }

}