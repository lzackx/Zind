import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zind_plugin/zind_app_unknown_page.dart';
import 'package:zind_plugin/zind_plugin.dart';
import 'package:zind_plugin/zind_route_model.dart';

class ZindRouterDelegate extends RouterDelegate<ZindRouteModel> with PopNavigatorRouterDelegateMixin<ZindRouteModel>, ChangeNotifier {
  ZindRouteModel _currentRouteModel = ZindRouteModel.defaultModel();
  Navigator _navigator;
  Map<String, WidgetBuilder> _pageRoutes;

  static ZindRouterDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is ZindRouterDelegate, 'Delegate type must match');
    return delegate as ZindRouterDelegate;
  }

  ZindRouterDelegate({
    ZindRouteModel initialRouteModel,
    Navigator navigator,
    Map<String, WidgetBuilder> pageRoutes,
  }) {
    if (initialRouteModel != null) {
      _currentRouteModel = initialRouteModel;
    }
    _navigator = navigator;
    _pageRoutes = pageRoutes;
  }

  @override
  GlobalKey<NavigatorState> navigatorKey = ZindPlugin.navigatorKey;

  @override
  ZindRouteModel get currentConfiguration => _currentRouteModel;

  // @override
  // Future<void> setInitialRoutePath(ZindRouteModel configuration) {
  //   print('setInitialRoutePath ${configuration.toJson()}');
  //   _currentRouteModel = configuration;
  //   return setNewRoutePath(configuration);
  // }

  @override
  Future<void> setNewRoutePath(ZindRouteModel configuration) {
    print('setNewRoutePath ${configuration.toJson()}');
    _currentRouteModel = configuration;
    return SynchronousFuture<void>(null);
  }

  @override
  Widget build(BuildContext context) {
    print('ZindRouteDelegate build');
    return this._buildRouterWidget(context);
  }

  Widget _buildRouterWidget(BuildContext context) {
    int routerType = 0;
    if (this._currentRouteModel != null) {
      print("_buildRouterWidget: ${this._currentRouteModel.toJson()}");
      routerType = this._currentRouteModel.parameters.public.routerType;
    }

    Widget routerWidget;
    // switch (routerType) {
    //   case 1: // Share
    //     routerWidget = Navigator(
    //       initialRoute: this._currentRouteModel.url,
    //       onGenerateInitialRoutes: _navigator.onGenerateInitialRoutes,
    //       onGenerateRoute: _navigator.onGenerateRoute,
    //       onUnknownRoute: _navigator.onUnknownRoute,
    //     );
    routerWidget = _pageRoutes[_currentRouteModel.url](context);
    // break;
    //   case 2: // PopUp
    //   case 3: // Stack
    //   case 0: // General
    //   default:
    //     routerWidget = this._navigator;
    //     break;
    // }

    return routerWidget;
  }

  void updatePage(ZindRouteModel routeModel) {
    print("updatePage: ${routeModel.toJson()}");
    _currentRouteModel = routeModel;
    notifyListeners();
  }
}
