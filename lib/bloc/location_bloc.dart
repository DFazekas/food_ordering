// Standard packages.
import 'dart:async';
// Custom packages.
import 'package:food_ordering/bloc/bloc.dart';
import 'package:food_ordering/data_layer/location.dart';

class LocationBloc implements Bloc {
  // Manages the stream and sink for Location.
  final _locationController = StreamController<Location>();

  // Exposes a public getter for the controller's stream.
  Stream<Location> get locationStream => _locationController.stream;

  void selectLocation(Location location) {
    _locationController.sink.add(location);
  }

  @override
  void dispose() {
    _locationController.close();
  }
}
