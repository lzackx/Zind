import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zind_plugin/zind_route_model.dart';

typedef RoutePushPageHandler = void Function(ZindRouteModel routeModel);
typedef RoutePopPageHandler = void Function(ZindRouteModel routeModel);
typedef RouteUpdatePageHandler = void Function(ZindRouteModel routeModel);

class ZindPlugin {
  static const MethodChannel _zind_channel = const MethodChannel('com.zind.engine.channel');
  static GlobalKey appKey = GlobalKey(debugLabel: "com.zind.key.Router");
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>(debugLabel: "com.zind.key.Navigator");
  static GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>(debugLabel: "com.zind.key.ScaffoldMessenger");

  static RoutePushPageHandler _routePushPageHandler;
  static RoutePopPageHandler _routePopPageHandler;
  static RouteUpdatePageHandler _routeUpdateRoutePageHandler;
  static RouteUpdatePageHandler _routeUpdateNavigatorPageHandler;

  static void setupChannel() {
    print("ZindPlugin setupChannel");
    _zind_channel.setMethodCallHandler(_handleChannelMethodCall);
  }

  static void setupRouteHandler(
      {@required RoutePushPageHandler routePushPageHandler,
      @required RoutePopPageHandler routePopPageHandler,
      @required RouteUpdatePageHandler routeUpdateRoutePageHandler,
        @required RouteUpdatePageHandler routeUpdateNavigatorPageHandler}) {
    print("ZindPlugin setupRouteHandler");
    _routePushPageHandler = routePushPageHandler;
    _routePopPageHandler = routePopPageHandler;
    _routeUpdateRoutePageHandler = routeUpdateRoutePageHandler;
    _routeUpdateNavigatorPageHandler = routeUpdateNavigatorPageHandler;
  }

  static Future<dynamic> _handleChannelMethodCall(MethodCall call) async {
    print("_handleChannelMethodCall");
    String method = call.method;
    String argumentsJSON = call.arguments as String;
    print("$method => $argumentsJSON");
    try {
      ZindRouteModel routeModel = ZindRouteModel.fromJson(argumentsJSON);
      switch (method) {
        case "pushPage":
          ZindPlugin.pushPage(routeModel);
          break;
        case "popPage":
          ZindPlugin.popPage(routeModel);
          break;
        case "updateRoutePage":
          ZindPlugin.updateRoutePage(routeModel);
          break;
        case "updateNavigatorPage":
          ZindPlugin.updateNavigatorPage(routeModel);
          break;
        default:
          return Future.value({"state": "101", "message": "wrong method"});
      }
    } catch (e) {
      print(e);
      return Future.value({"state": "0", "message": "success"});
    }
    return Future.value({"state": "0", "message": "success"});
  }

  static void pushPage(ZindRouteModel routeModel) {
    print("flutter pushPage ${routeModel.toJson()}");
    if (_routePushPageHandler != null) {
      print("routePushPageHandler ${routeModel.toJson()}");
      _routePushPageHandler(routeModel);
    }
  }

  static void popPage(ZindRouteModel routeModel) {
    print("flutter popPage ${routeModel.toJson()}");
    if (_routePopPageHandler != null) {
      print("routePopPageHandler ${routeModel.toJson()}");
      _routePopPageHandler(routeModel);
    }
  }

  static void updateRoutePage(ZindRouteModel routeModel) {
    print("flutter updatePage ${routeModel.toJson()}");
    if (_routeUpdateRoutePageHandler != null) {
      print("routeUpdateRoutePageHandler ${routeModel.toJson()}");
      _routeUpdateRoutePageHandler(routeModel);
    }
  }
  
  static void updateNavigatorPage(ZindRouteModel routeModel) {
    print("flutter updatePage ${routeModel.toJson()}");
    if (_routeUpdateNavigatorPageHandler != null) {
      print("routeUpdateNavigatorPageHandler ${routeModel.toJson()}");
      _routeUpdateNavigatorPageHandler(routeModel);
    }
  }
  
}
