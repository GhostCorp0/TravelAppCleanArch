
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:riverpod_clean_architecture/features/trip/data/datasources/trip_local_datasource.dart';
import 'package:riverpod_clean_architecture/features/trip/data/models/trip_model.dart';
import 'package:riverpod_clean_architecture/features/trip/data/repositories/trip_repository_impl.dart';
import 'package:riverpod_clean_architecture/features/trip/domain/repositories/trip_repository.dart';
import 'package:riverpod_clean_architecture/features/trip/domain/usecases/add_trip.dart';
import 'package:riverpod_clean_architecture/features/trip/domain/usecases/delete_trip.dart';
import 'package:riverpod_clean_architecture/features/trip/domain/usecases/get_trips.dart';

import '../../domain/entities/trip.dart';

final tripLocalDataSourceProvider = Provider<TripLocalDatasource>((ref){
  final Box<TripModel> tripBox = Hive.box("trips");
  return TripLocalDatasource(tripBox);
});

final tripRepositoryProvider = Provider<TripRepository>((ref){
  final localDataSource = ref.read(tripLocalDataSourceProvider);
  return TripRepositoryImpl(localDataSource);
});

final addTripProvider = Provider<AddTrip>((ref){
  final repository = ref.read(tripRepositoryProvider);
  return AddTrip(repository);
});

final getTripProvider = Provider<GetTrips>((ref){
  final repository = ref.read(tripRepositoryProvider);
  return GetTrips(repository);
});

final deleteTripProvider = Provider<DeleteTrip>((ref){
  final repository = ref.read(tripRepositoryProvider);
  return DeleteTrip(repository);
});

final tripListNotifierProvider = StateNotifierProvider<TripListNotifier,List<Trip>>((ref) {
  final getTrips = ref.read(getTripProvider);
  final addTrip = ref.read(addTripProvider);
  final deleteTrip = ref.read(deleteTripProvider);

  return TripListNotifier(getTrips,addTrip,deleteTrip);
});

class TripListNotifier extends StateNotifier<List<Trip>> {
  final GetTrips _getTrips;
  final AddTrip _addTrip;
  final DeleteTrip _deleteTrip;

  TripListNotifier(this._getTrips,this._addTrip,this._deleteTrip):super([]);

  Future<void> addNewTrip(Trip trip) async{
    await _addTrip(trip);
  }

  Future<void> removeTrip(int tripId) async{
    await _deleteTrip(tripId);
  }

  Future<void> loadTrips() async {
    await _getTrips();
  }
}
