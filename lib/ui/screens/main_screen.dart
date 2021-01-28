import 'package:flutter/material.dart';
import 'package:food_ordering/bloc/bloc_provider.dart';
import 'package:food_ordering/bloc/location_bloc.dart';
import 'package:food_ordering/data_layer/location.dart';
import 'package:food_ordering/ui/screens/dashboard_page.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: BlocProvider.of<LocationBloc>(context).locationStream,
        builder: (_, snapshot) {
          // final location = snapshot.data;
          final location = Location.mock(
              {"id": 89, "type": "city", "title": "Toronto, Ontario"});

          // TODO: pass location to Dashboard().
          return Dashboard(location: location);
        });
  }
}
