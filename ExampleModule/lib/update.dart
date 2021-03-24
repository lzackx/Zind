import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zind_plugin/zind_app.dart';

class Update extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          SystemNavigator.pop(animated: false);
        },
        child: Center(
          child: Container(
            width: 100,
            height: 100,
            color: Colors.orangeAccent,
            child: Text(
              "popup() => update",
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