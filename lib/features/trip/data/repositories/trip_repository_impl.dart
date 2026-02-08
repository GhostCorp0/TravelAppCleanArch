import 'package:riverpod_clean_architecture/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:riverpod_clean_architecture/features/trip/domain/entities/trip.dart';
import 'package:riverpod_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

import '../models/trip_model.dart';

class TripRepositoryImpl implements TripRepository{
  final TripLocalDatasource localDatasource;

  TripRepositoryImpl(this.localDatasource);

  @override
  Future<void> addTrip(Trip trip) async{
    final tripModel = TripModel.fromEntity(trip);
    localDatasource.addTrip(tripModel);
  }

  @override
  Future<void> deleteTrip(int index) async{
    localDatasource.deleteTrip(index);
  }

  @override
  Future<List<Trip>> getTrips() async{
    final tripModels = localDatasource.getTrips();
    List<Trip> res = tripModels.map((model) => model.toEntity()).toList();
    return res;
  }

}