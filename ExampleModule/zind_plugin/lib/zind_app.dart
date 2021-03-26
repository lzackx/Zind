import 'dart:io';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:zind_plugin/zind_app_unknown_page.dart';
import 'package:zind_plugin/zind_plugin.dart';
import 'package:zind_plugin/zind_route_information_parser.dart';
import 'package:zind_plugin/zind_route_model.dart';
import 'package:zind_plugin/zind_router_delegate.dart';

class ZindApp {
  ZindRouteModel _routeModel;
  Map<String, WidgetBuilder> _pageRoutes;

  ZindApp({@required ZindRouteModel routeModel, @required Map<String, WidgetBuilder> pageRoutes}) {
    this._routeModel = routeModel;
    this._pageRoutes = pageRoutes;
    print("ZindApp construction:\nrouteModel: ${this._routeModel.toJson()}\npageRoutes: ${this._pageRoutes.toString()}");
    WidgetsFlutterBinding.ensureInitialized();
    ZindPlugin.setupChannel();
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
  }

  MaterialApp createApp(BuildContext context, {ZindRouteInformationParser routeInformationParser, ZindRouteDelegate routeDelegate}) {
    ZindRouteInformationParser rip = ZindRouteInformationParser();
    ZindRouteDelegate rd = ZindRouteDelegate(
      onGenerateInitialRoutes: this.defaultGenerateInitialRoutes,
      onGenerateRoute: this.defaultOnGenerateRoute,
      onUnknownRoute: this.defaultOnUnknownRoute,
    );
    if (routeInformationParser != null) {
      rip = routeInformationParser;
    }
    if (routeDelegate != null) {
      rd = routeDelegate;
    }

    return MaterialApp.router(
      scaffoldMessengerKey: ZindPlugin.scaffoldMessengerKey,
      routeInformationParser: rip,
      routerDelegate: rd,
    );
  }

  List<Route<dynamic>> defaultGenerateInitialRoutes(NavigatorState navigator, String initialRouteName) {
    final List<Route<dynamic>> result = <Route<dynamic>>[];
    print("defaultGenerateInitialRoutes: $initialRouteName");
    this._pageRoutes.forEach(
      (String route, WidgetBuilder builder) {
        RouteSettings routeSettings = RouteSettings(name: route, arguments: null);
        Route<dynamic> pageRoute = navigator.widget.onGenerateRoute(routeSettings);
        result.add(pageRoute);
      },
    );
    print("defaultGenerateInitialRoutes: ${result.toString()}");
    return result.cast<Route<dynamic>>();
  }

  Route<dynamic> defaultOnGenerateRoute(RouteSettings settings) {
    print("onGenerateRoute: $settings");
    return PageRouteBuilder(
      settings: RouteSettings(name: this._routeModel.url, arguments: this._routeModel.parameters),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        if (this._pageRoutes.keys.contains(settings.name)) {
          Widget page = this._pageRoutes[settings.name](context);
          return page;
        } else {
          return ZindAppUnknownPage();
        }
      },
    );
  }

  Route<dynamic> defaultOnUnknownRoute(RouteSettings settings) {
    print("onUnknownRoute: $settings");
    return PageRouteBuilder(
      settings: RouteSettings(name: this._routeModel.url, arguments: this._routeModel.parameters),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return ZindAppUnknownPage();
      },
    );
  }

  void handleRoutePushPage(ZindRouteModel routeModel) {
    print("handleRoutePushPage: ${ZindPlugin.navigatorKey.currentContext}");
    Navigator.push(
      ZindPlugin.navigatorKey.currentContext,
      PageRouteBuilder(
        settings: RouteSettings(
          name: routeModel.url,
          arguments: routeModel.parameters.private.toMap(),
        ),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          Widget page = this._pageRoutes[routeModel.url](context);
          return page;
        },
      ),
    );
  }

  void handleRoutePopPage(ZindRouteModel routeModel) {
    print("handleRoutePopPage: ${ZindPlugin.navigatorKey.currentContext}");
    Navigator.pop(ZindPlugin.navigatorKey.currentContext);
  }

  void handleRouteUpdatePage(ZindRouteModel routeModel) {
    print("handleRouteUpdatePage: ${ZindPlugin.navigatorKey.currentWidget}");
    // print("handleRouteUpdatePage => ${ui.window.defaultRouteName}");
    ZindRouteDelegate.of(ZindPlugin.navigatorKey.currentContext).updatePage(routeModel);
    Navigator.pushReplacement(
      ZindPlugin.navigatorKey.currentContext,
      PageRouteBuilder(
        settings: RouteSettings(
          name: routeModel.url,
          arguments: routeModel.parameters.private.toMap(),
        ),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          print("pushReplacement ${routeModel.toJson()}");
          Widget page = this._pageRoutes[routeModel.url](context);
          return page;
        },
      ),
    );
  }
}

// class ZindApp {
//   final ZindRouteModel routeModel;
//   final Map<String, WidgetBuilder> pageRoutes;
//
//   ZindApp({@required this.routeModel, @required this.pageRoutes}) {
//     WidgetsFlutterBinding.ensureInitialized();
//     ZindPlugin.setupChannel();
//   }
//
//   MaterialApp createApp(BuildContext context) {
//     ZindPlugin.setupRouteHandler(
//       routePushPageHandler: (ZindRouteModel routeModel) {
//         this.handleRoutePushPage(routeModel);
//       },
//       routePopPageHandler: (ZindRouteModel routeModel) {
//         this.handleRoutePopPage(routeModel);
//       },
//       routeUpdatePageHandler: (ZindRouteModel routeModel) {
//         this.handleRouteUpdatePage(routeModel);
//       },
//     );
//     return MaterialApp(
//       navigatorKey: ZindPlugin.navigatorKey,
//       initialRoute: routeModel.url,
//       routes: this.pageRoutes,
//       onUnknownRoute: (RouteSettings settings) {
//         print("onUnknownRoute: $settings");
//         return PageRouteBuilder(
//           pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//             return ZindAppUnknownPage();
//           },
//         );
//       },
//     );
//   }
//
//   void handleRoutePushPage(ZindRouteModel routeModel) {
//     print("handleRoutePushPage");
//     Navigator.push(
//       ZindPlugin.navigatorKey.currentContext,
//       PageRouteBuilder(
//         settings: RouteSettings(
//           name: routeModel.url,
//           arguments: routeModel.parameters.private.toMap(),
//         ),
//         pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//           Widget page = this.pageRoutes[routeModel.url](context);
//           return page;
//         },
//       ),
//     );
//   }
//
//   void handleRoutePopPage(ZindRouteModel routeModel) {
//     print("handleRoutePopPage");
//     Navigator.pop(ZindPlugin.navigatorKey.currentContext);
//   }
//
//   void handleRouteUpdatePage(ZindRouteModel routeModel) {
//     print("handleRouteUpdatePage");
//     Navigator.pushReplacement(
//       ZindPlugin.navigatorKey.currentContext,
//       PageRouteBuilder(
//         settings: RouteSettings(
//           name: routeModel.url,
//           arguments: routeModel.parameters.private.toMap(),
//         ),
//         pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
//           print("pushReplacement ${routeModel.toJson()}");
//           Widget page = this.pageRoutes[routeModel.url](context);
//           return page;
//         },
//       ),
//     );
//   }
// }
