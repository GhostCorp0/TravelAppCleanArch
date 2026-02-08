import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_clean_architecture/features/trip/presentation/providers/trip_providers.dart';

import '../../domain/entities/trip.dart';

class AddTripScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController(text: "City 1");
  final _descController = TextEditingController(text: "Best city over");
  final _locationController = TextEditingController(text: "Paris");
  final _pictureController = TextEditingController(text: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbW5Jh3t8QI-Df0IKmP-dMka8DosHdvSV2jw&s");

  List<String> pictures = [];

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration:InputDecoration(labelText: "Title"),
          ),
          TextFormField(
            controller: _descController,
            decoration:InputDecoration(labelText: "Description"),
          ),
          TextFormField(
            controller: _locationController,
            decoration:InputDecoration(labelText: "Location"),
          ),
          TextFormField(
            controller: _pictureController,
            decoration:InputDecoration(labelText: "Photo"),
          ),
          ElevatedButton(onPressed:(){
            pictures.add(_pictureController.text);
            if(_formKey.currentState!.validate()){
              final newTrip = Trip(
                title: _titleController.text,
                description: _descController.text,
                date: DateTime.now(),
                location:_locationController.text,
                photos: pictures
              );
              ref.read(tripListNotifierProvider.notifier).addNewTrip(newTrip);
              ref.watch(tripListNotifierProvider.notifier).loadTrips();
            }
          }, child:Text("Add trip"))
        ],
      ),
    );
  }
}
