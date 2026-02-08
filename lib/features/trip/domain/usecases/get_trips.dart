import 'package:riverpod_clean_architecture/features/trip/domain/entities/trip.dart';
import 'package:riverpod_clean_architecture/features/trip/domain/repositories/trip_repository.dart';

class GetTrips {
  final TripRepository repository;

  GetTrips(this.repository);

  Future<List<Trip>> call(){
    return repository.getTrips();
  }
}