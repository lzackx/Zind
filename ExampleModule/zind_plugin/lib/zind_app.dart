import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zind_plugin/zind_app_unknown_page.dart';
import 'package:zind_plugin/zind_plugin.dart';
import 'package:zind_plugin/zind_route_model.dart';

class ZindApp {
  final ZindRouteModel routeModel;
  final Map<String, WidgetBuilder> pageRoutes;

  ZindApp({@required this.routeModel, @required this.pageRoutes}) {
    WidgetsFlutterBinding.ensureInitialized();
    ZindPlugin.setupChannel();
  }

  MaterialApp createApp(BuildContext context) {
    ZindPlugin.setupRouteHandler(
      routePushPageHandler: (ZindRouteModel routeModel) {
        this.handleRoutePushPage(routeModel);
      },
      routePopPageHandler: (ZindRouteModel routeModel) {
        this.handleRoutePopPage(routeModel);
      },
      routeUpdatePageHandler: (ZindRouteModel routeModel) {
        this.handleRouteUpdatePage(routeModel);
      },
    );
    return MaterialApp(
      navigatorKey: ZindPlugin.navigatorKey,
      initialRoute: routeModel.url,
      routes: this.pageRoutes,
      onUnknownRoute: (RouteSettings settings) {
        print("onUnknownRoute: $settings");
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return ZindAppUnknownPage();
          },
        );
      },
    );
  }

  void handleRoutePushPage(ZindRouteModel routeModel) {
    print("handleRoutePushPage");
    Navigator.push(
      ZindPlugin.navigatorKey.currentContext,
      PageRouteBuilder(
        settings: RouteSettings(
          name: routeModel.url,
          arguments: routeModel.parameters.private.toMap(),
        ),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          Widget page = this.pageRoutes[routeModel.url](context);
          return page;
        },
      ),
    );
  }

  void handleRoutePopPage(ZindRouteModel routeModel) {
    print("handleRoutePopPage");
    Navigator.pop(ZindPlugin.navigatorKey.currentContext);
  }

  void handleRouteUpdatePage(ZindRouteModel routeModel) {
    print("handleRouteUpdatePage");
    Navigator.pushReplacement(
      ZindPlugin.navigatorKey.currentContext,
      PageRouteBuilder(
        settings: RouteSettings(
          name: routeModel.url,
          arguments: routeModel.parameters.private.toMap(),
        ),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          print("pushReplacement ${routeModel.toJson()}");
          Widget page = this.pageRoutes[routeModel.url](context);
          return page;
        },
      ),
    );
  }
}
