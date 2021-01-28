import 'dart:async';

import 'package:food_ordering/bloc/bloc.dart';
import 'package:food_ordering/data_layer/location.dart';
import 'package:food_ordering/data_layer/restaurant.dart';
import 'package:food_ordering/data_layer/zomato_client.dart';

class RestaurantBloc implements Bloc {
  final Location location;
  final _client = ZomatoClient();

  // Manages the stream and sink for Restaurants.
  final _restaurantController = StreamController<List<Restaurant>>();

  Stream<List<Restaurant>> get stream => _restaurantController.stream;

  RestaurantBloc(this.location);

  /// GET a list of Restaurant objects that match the query within a location.
  void submitQuery(String query) async {
    final results = await _client.fetchRestaurants(location, query);
    _restaurantController.sink.add(results);
  }

  @override
  void dispose() {
    _restaurantController.close();
  }
}
