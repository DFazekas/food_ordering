// Standard packages.
import 'package:flutter/material.dart';
// External packages.
// Custom packages.
import 'package:food_ordering/bloc/bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final Widget child;
  final T bloc;

  const BlocProvider({Key key, @required this.bloc, @required this.child})
      : super(key: key);

  /// Allows an ancestor widget to access the BLoCProvider from a descendent in widget tree.
  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider = context.findAncestorWidgetOfExactType();
    return provider.bloc;
  }

  @override
  State createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  /// A passthrough to the widget's child. This widget will not render anything.
  @override
  Widget build(_) => widget.child;

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
