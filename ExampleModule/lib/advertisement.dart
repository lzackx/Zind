import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zind_plugin/zind_app.dart';

class Advertisement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          SystemNavigator.pop();
        },
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.cyan,
            child: Text(
              "popup() => advertisement",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
