// Standard packages.
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
// External packages.
import 'package:http/http.dart' as http;
// Custom packages.
import 'package:food_ordering/data_layer/location.dart';
import 'package:food_ordering/data_layer/restaurant.dart';
import "package:food_ordering/.secrets.dart";

class ZomatoClient {
  // TODO: remove this before committing. Oh god I hope I remember.

  final _host = "developers.zomato.com";
  final _contextRoot = "api/v2.1";

  Map<String, String> get _headers =>
      {'Accept': 'application/json', 'user-key': SECRETS.zomatoClientKey};

  /// Gets a list of location suggestions based on query.
  Future<List<Location>> fetchLocations(String query) async {
    final results = await request(
        path: 'locations', parameters: {'query': query, 'count': '10'});
    final suggestions = results['location_suggestions'];
    return suggestions
        .map<Location>((json) => Location.fromJson(json))
        .toList(growable: false);
  }

  /// Gets a list of restaurants in a given location based on a query.
  Future<List<Restaurant>> fetchRestaurants(
      Location location, String query) async {
    final results = await request(path: 'search', parameters: {
      'entity_id': location.id.toString(),
      'entity_type': location.type,
      'q': query,
      'count': '10'
    });

    final restaurants = results['restaurants']
        .map<Restaurant>((json) => Restaurant.fromJson(json['restaurant']))
        .toList(growable: false);

    return restaurants;
  }

  /// Performs http.get request. Returns decoded JSON object.
  Future<Map> request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, "$_contextRoot/$path", parameters);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    return jsonObject;
  }
}
