import 'package:flutter/material.dart';
import 'registrationscreen.dart';
import 'loginscreen.dart';
import 'welcomescreen.dart';
import 'activityscreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: welcomescreen.id,
        routes: {
          welcomescreen.id: (context) => welcomescreen(),
          loginscreen.id: (context) => loginscreen(),
          registrationscreen.id: (context) => registrationscreen(),
          activityscreen.id: (context) => activityscreen(),
        }
    );
  }
}
