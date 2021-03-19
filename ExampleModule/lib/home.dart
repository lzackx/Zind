import 'package:flutter/material.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(
          "main() => home",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }

}