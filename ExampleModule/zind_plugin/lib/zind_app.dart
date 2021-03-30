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
    _routeModel = routeModel;
    _pageRoutes = pageRoutes;
    print("ZindApp construction:\nrouteModel: ${_routeModel.toJson()}\npageRoutes: ${_pageRoutes.toString()}");
    WidgetsFlutterBinding.ensureInitialized();
    ZindPlugin.setupChannel();
    ZindPlugin.setupRouteHandler(
      routePushPageHandler: (ZindRouteModel routeModel) {
        _handleRoutePushPage(routeModel);
      },
      routePopPageHandler: (ZindRouteModel routeModel) {
        _handleRoutePopPage(routeModel);
      },
      routeUpdateRoutePageHandler: (ZindRouteModel routeModel) {
        _handleRouteUpdateRoutePage(routeModel);
      },
      routeUpdateNavigatorPageHandler: (ZindRouteModel routeModel) {
        _handleRouteUpdateNavigatorPage(routeModel);
      },
    );
  }

  /// ==== setupRouteHandler ====
  void _handleRoutePushPage(ZindRouteModel routeModel) {
    print("handleRoutePushPage: ${ZindPlugin.navigatorKey.currentContext}");
    Navigator.push(
      ZindPlugin.navigatorKey.currentContext,
      PageRouteBuilder(
        settings: RouteSettings(
          name: routeModel.url,
          arguments: routeModel.parameters.private.toMap(),
        ),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          Widget page = _pageRoutes[routeModel.url](context);
          return page;
        },
      ),
    );
  }

  void _handleRoutePopPage(ZindRouteModel routeModel) {
    print("handleRoutePopPage: ${ZindPlugin.navigatorKey.currentContext}");
    Navigator.pop(ZindPlugin.navigatorKey.currentContext);
  }

  void _handleRouteUpdateRoutePage(ZindRouteModel routeModel) {
    print("handleRouteUpdateRoutePage: ${(ZindPlugin.appKey.currentWidget as MaterialApp).routerDelegate}");
    ((ZindPlugin.appKey.currentWidget as MaterialApp).routerDelegate as ZindRouterDelegate).updatePage(routeModel);
  }

  void _handleRouteUpdateNavigatorPage(ZindRouteModel routeModel) {
    print("handleRouteUpdateNavigatorPage: ${ZindPlugin.navigatorKey.currentWidget}");
    Navigator.pushReplacement(
      ZindPlugin.navigatorKey.currentContext,
      PageRouteBuilder(
        settings: RouteSettings(
          name: routeModel.url,
          arguments: routeModel.parameters.private.toMap(),
        ),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          print("pushReplacement ${routeModel.toJson()}");
          Widget page = _pageRoutes[routeModel.url](context);
          return page;
        },
      ),
    );
  }

  /// Easy to use
  MaterialApp createApp(BuildContext context, {ZindRouteInformationParser routeInformationParser, ZindRouterDelegate routeDelegate}) {
    // RouteInformationParser
    RouteInformationParser rip = _defaultRouteInformationParser(context);
    if (routeInformationParser != null) {
      rip = routeInformationParser;
    }
    // RouteDelegate
    ZindRouterDelegate rd = _defaultRouteDelegate(context);
    if (routeDelegate != null) {
      rd = routeDelegate;
    }
    return MaterialApp.router(
      key: ZindPlugin.appKey,
      scaffoldMessengerKey: ZindPlugin.scaffoldMessengerKey,
      routeInformationParser: rip,
      routerDelegate: rd,
    );
  }

  ZindRouteInformationParser _defaultRouteInformationParser(BuildContext context) {
    ZindRouteInformationParser routeInformationParser = ZindRouteInformationParser();
    return routeInformationParser;
  }

  ZindRouterDelegate _defaultRouteDelegate(BuildContext context) {
    // List<Page<dynamic>> pages = _pageRoutes.map((route, builder) {
    //   return MaterialPage(name:name, child: builder(context));
    // });
    List<Page<dynamic>> pages = [];
    _pageRoutes.forEach((String name, WidgetBuilder builder) {
      MaterialPage page = MaterialPage(name: name, child: builder(context));
      pages.add(page);
    });

    Navigator navigator = Navigator(
      key: ZindPlugin.navigatorKey,
      initialRoute: _routeModel.url,
      pages: pages,
      onGenerateInitialRoutes: _onGenerateInitialRoutes,
      onGenerateRoute: _onGenerateRoute,
      onUnknownRoute: _onUnknownRoute,
    );
    ZindRouterDelegate routerDelegate = ZindRouterDelegate(initialRouteModel: _routeModel, navigator: navigator, pageRoutes: _pageRoutes);
    return routerDelegate;
  }

  // ZindRouterDelegate _defaultRouteDelegate(BuildContext context) {
  //   Navigator navigator = Navigator(
  //     key: ZindPlugin.navigatorKey,
  //     initialRoute: _routeModel.url,
  //     onGenerateInitialRoutes: _onGenerateInitialRoutes,
  //     onGenerateRoute: _onGenerateRoute,
  //     onUnknownRoute: _onUnknownRoute,
  //   );
  //   ZindRouterDelegate routerDelegate = ZindRouterDelegate(initialRouteModel: _routeModel, navigator: navigator);
  //   return routerDelegate;
  // }

  /// default Navigator methods
  List<Route<dynamic>> _onGenerateInitialRoutes(NavigatorState navigator, String initialRouteName) {
    final List<Route<dynamic>> result = <Route<dynamic>>[];
    print("_onGenerateInitialRoutes: $initialRouteName");
    // Only add 1 route, because the stack of route is not managed by "/"
    RouteSettings routeSettings = RouteSettings(name: initialRouteName, arguments: _routeModel);
    Route<dynamic> pageRoute = navigator.widget.onGenerateRoute(routeSettings);
    result.add(pageRoute);
    return result.cast<Route<dynamic>>();
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    print("_onGenerateRoute: ${settings.toString()}");
    final String name = settings.name;
    if (_pageRoutes.keys.contains(name) == false) {
      return null;
    }
    final Route<dynamic> route = MaterialPageRoute(
      settings: settings,
      maintainState: true,
      fullscreenDialog: true,
      builder: (BuildContext context) {
        Widget page = _pageRoutes[settings.name](context);
        print("generate MaterialPageRoute: ${settings.toString()}");
        return page;
      },
    );
    return route;
  }

  Route<dynamic> _onUnknownRoute(RouteSettings settings) {
    print("_onUnknownRoute: $settings");
    return PageRouteBuilder(
      settings: RouteSettings(name: "Unknown", arguments: _routeModel.parameters),
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        print("generate UnknownRoute: $settings");
        return ZindAppUnknownPage();
      },
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
