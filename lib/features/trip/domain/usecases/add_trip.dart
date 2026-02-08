import 'package:riverpod_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

import '../entities/trip.dart';

class AddTrip {
  final TripRepository repository;

  AddTrip(this.repository);

  Future<void> call(Trip trip){
    return repository.addTrip(trip);
  }
}