// Standard packages.
import 'package:flutter/material.dart';
// External packages.
import 'package:firebase_core/firebase_core.dart';
// Custom packages.
import 'package:food_ordering/screens/dashboard_page.dart';

void main() {
  // MUST BE FIRST CALL.
  // App crashes due to async nature of Firebase within main().
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            // Check for errors.
            if (snapshot.hasError) {
              return Scaffold(
                body: const Center(child: Text("Error")),
              );
            }

            // Once complete, show your application.
            if (snapshot.connectionState == ConnectionState.done) {
              return Dashboard();
            }

            // Otherwise, show something whilst waiting for initialization to complete.
            return Scaffold(body: const Center(child: Text("Loading...")));
          }),
    );
  }
}
