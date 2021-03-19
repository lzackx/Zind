import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:zind_plugin/zind_plugin.dart';

import 'package:zind_plugin/zind_app.dart';
import 'package:zind_module/home.dart';
import 'package:zind_module/account.dart';

void main() => runApp(BaseApp("main()", Colors.white));

@pragma('vm:entry-point')
void shared() => runApp(ShareApp("shared()", Colors.lightBlue));

@pragma('vm:entry-point')
void popup() => runApp(BaseApp("popup()", Colors.red));

@pragma('vm:entry-point')
void carousel() => runApp(BaseApp("Carousel()", Colors.lightGreen));

class ShareApp extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  ZindApp _app;

  ShareApp(this.title, this.backgroundColor) {
    Map<String, WidgetBuilder> pageRoutes = {
      "/home": (BuildContext context) => Home(),
      "/account": (BuildContext context) => Account(),
    };
    _app = ZindApp(initialRoute: "/home", pageRoutes: pageRoutes);
  }

  @override
  Widget build(BuildContext context) {
    print("MyApp build");
    print("title: ${this.title} initialRoute ${ui.window.defaultRouteName}");

    return _app.createApp(context);
  }
}

class BaseApp extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  ZindApp _app;

  BaseApp(this.title, this.backgroundColor) {
    Map<String, WidgetBuilder> pageRoutes = {
      "/home": (BuildContext context) => Home(),
      "/account": (BuildContext context) => Account(),
    };
    _app = ZindApp(initialRoute: "/home", pageRoutes: pageRoutes);
  }

  @override
  Widget build(BuildContext context) {
    print("MyApp build");
    print("title: ${this.title} initialRoute ${ui.window.defaultRouteName}");

    return _app.createApp(context);
  }
}
