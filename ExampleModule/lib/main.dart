import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zind_module/advertisement.dart';
import 'package:zind_module/update.dart';
import 'package:zind_plugin/zind_plugin.dart';

import 'package:zind_plugin/zind_app.dart';
import 'package:zind_module/home.dart';
import 'package:zind_module/account.dart';
import 'package:zind_plugin/zind_route_model.dart';

void main() {
  runApp(BaseApp());
}

@pragma('vm:entry-point')
void shared() {
  print("share entry point");
  runApp(ShareApp());
}

@pragma('vm:entry-point')
void popup() {
  print("pop up entry point");
  runApp(PopUpApp());
}

class PopUpApp extends StatelessWidget {
  static Map<String, WidgetBuilder> _pageRoutes = {
    "/update": (BuildContext context) => Update(),
    "/advertisement": (BuildContext context) => Advertisement(),
  };
  static ZindApp _app;

  PopUpApp() {
    print("PopUpApp initialRoute: ${ui.window.defaultRouteName}");
    ZindRouteModel routeModel = ZindRouteModel.defaultModel();
    try {
      routeModel = ZindRouteModel.fromJson(ui.window.defaultRouteName);
    } catch (e) {
      print("decode initialRoute exception: $e");
    } finally {
      print("finally error");
    }
    _app = ZindApp(routeModel: routeModel, pageRoutes: _pageRoutes);
  }

  @override
  Widget build(BuildContext context) {
    print("PopUpApp build");
    return _app.createApp(context);
  }
}

class ShareApp extends StatelessWidget {
  static Map<String, WidgetBuilder> _pageRoutes = {
    "/home": (BuildContext context) => Home(),
    "/account": (BuildContext context) => Account(),
  };
  static ZindApp _app;

  ShareApp() {
    print("ShareApp initialRoute: ${ui.window.defaultRouteName}");
    ZindRouteModel routeModel = ZindRouteModel.defaultModel();
    routeModel.url = "/home";
    try {
      routeModel = ZindRouteModel.fromJson(ui.window.defaultRouteName);
    } catch (e) {
      print("decode initialRoute exception: $e");
    } finally {
      print("finally error");
    }
    _app = ZindApp(routeModel: routeModel, pageRoutes: _pageRoutes);
  }

  @override
  Widget build(BuildContext context) {
    print("PopUpApp build");
    return _app.createApp(context);
  }
}

class BaseApp extends StatelessWidget {
  static Map<String, WidgetBuilder> _pageRoutes = {};
  static ZindApp _app;

  BaseApp() {
    print("initialRoute: ${ui.window.defaultRouteName}");
    ZindRouteModel routeModel = ZindRouteModel.defaultModel();
    try {
      routeModel = ZindRouteModel.fromJson(ui.window.defaultRouteName);
    } catch (e) {
      print("decode initialRoute exception: $e");
    } finally {
      print("finally error");
    }
    _app = ZindApp(routeModel: routeModel, pageRoutes: _pageRoutes);
  }

  @override
  Widget build(BuildContext context) {
    print("PopUpApp build");
    return _app.createApp(context);
  }
}
