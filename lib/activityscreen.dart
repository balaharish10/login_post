import 'package:flutter/material.dart';
class activityscreen extends StatelessWidget {
  static String id="activity screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Center
            (child: Text("successfully logged in",style: TextStyle(fontSize: 30.0),))),
    );
  }
}
