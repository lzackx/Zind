import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZindAppPreloadPage extends StatelessWidget {
  Color _backgroundColor;
  Color _contentBackgroundColor;

  ZindAppPreloadPage({Color backgroundColor = Colors.transparent, Color contentBackgroundColor = Colors.transparent}) {
    _backgroundColor = backgroundColor;
    _contentBackgroundColor = contentBackgroundColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: GestureDetector(
        onTap: () {
          SystemNavigator.pop(animated: false);
        },
        child: Container(
          color: _contentBackgroundColor,
        ),
      ),
    );
  }
}
