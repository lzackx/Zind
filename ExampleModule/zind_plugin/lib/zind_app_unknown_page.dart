import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZindAppUnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          SystemNavigator.pop(animated: false);
        },
        child: Center(
          child: Text(
            "Unknown Page",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}