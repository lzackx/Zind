import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zind_plugin/zind_plugin.dart';
import 'package:zind_plugin/zind_route_model.dart';

class ZindApp {
  final String initialRoute;
  final Map<String, WidgetBuilder> pageRoutes;

  ZindApp({@required this.initialRoute, @required this.pageRoutes});

  MaterialApp createApp(BuildContext context) {
    ZindPlugin.setupChannel();
    return MaterialApp(
      navigatorKey: GlobalKey(debugLabel: "com.zind.key.navigator"),
      initialRoute: this.initialRoute,
      onGenerateRoute: (setting) {
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            print("onGenerateRoute: $setting");
            Widget page = this.pageRoutes[setting.name](context);
            return page;
          },
        );
      },
      onUnknownRoute: (RouteSettings settings) {
        print("onUnknownRoute: $settings");
        return PageRouteBuilder(
          pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
            return MaterialAppHome(this.pageRoutes);
          },
        );
      },
      home: MaterialAppHome(this.pageRoutes),
    );
  }
}

class MaterialAppHome extends StatelessWidget {
  final Map<String, WidgetBuilder> pageRoutes;

  MaterialAppHome(this.pageRoutes);

  @override
  Widget build(BuildContext context) {
    ZindPlugin.setupRouteHandler(
      routePushPageHandler: (ZindRouteModel routeModel) {
        this.setupRoutePushPageHandler(context, routeModel);
      },
      routePopPageHandler: (ZindRouteModel routeModel) {
        this.setupRoutePopPageHandler(context, routeModel);
      },
      routeUpdatePageHandler: (ZindRouteModel routeModel) {
        this.setupRouteUpdatePageHandler(context, routeModel);
      },
    );
    return this.pageRoutes.values.first(context);
  }

  void setupRoutePushPageHandler(BuildContext context, ZindRouteModel routeModel) {
    Navigator.push(
      context,
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

  void setupRoutePopPageHandler(BuildContext context, ZindRouteModel routeModel) {
    Navigator.pop(context);
  }

  void setupRouteUpdatePageHandler(BuildContext context, ZindRouteModel routeModel) {
    Navigator.pushReplacement(
      context,
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
}
