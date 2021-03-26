import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zind_plugin/zind_app_unknown_page.dart';
import 'package:zind_plugin/zind_plugin.dart';
import 'package:zind_plugin/zind_route_model.dart';

class ZindRouteDelegate extends RouterDelegate<ZindRouteModel> with PopNavigatorRouterDelegateMixin<ZindRouteModel>, ChangeNotifier {
  final RouteFactory onGenerateRoute;
  final RouteFactory onUnknownRoute;
  final RouteListFactory onGenerateInitialRoutes;
  ZindRouteModel _routeModel;
  Navigator _navigator;

  static ZindRouteDelegate of(BuildContext context) {
    final delegate = Router.of(context).routerDelegate;
    assert(delegate is ZindRouteDelegate, 'Delegate type must match');
    return delegate as ZindRouteDelegate;
  }

  ZindRouteDelegate({
    @required this.onGenerateInitialRoutes,
    @required this.onGenerateRoute,
    this.onUnknownRoute,
  }) {
    _navigator = Navigator(
      key: ZindPlugin.navigatorKey,
      onGenerateInitialRoutes: this.onGenerateInitialRoutes ?? Navigator.defaultGenerateInitialRoutes,
      onGenerateRoute: this.onGenerateRoute,
      onUnknownRoute: this.onUnknownRoute,
    );
  }

  @override
  GlobalKey<NavigatorState> navigatorKey = ZindPlugin.navigatorKey;

  // @override
  ZindRouteModel get currentConfiguration => _routeModel; //_stack.isNotEmpty ? _stack.last : null;

  @override
  Future<void> setInitialRoutePath(ZindRouteModel configuration) {
    print('setInitialRoutePath ${configuration.toJson()}');
    return setNewRoutePath(configuration);
  }

  @override
  Future<void> setNewRoutePath(ZindRouteModel configuration) {
    print('setNewRoutePath ${configuration.toJson()}');
    return SynchronousFuture<void>(null);
  }

  @override
  Widget build(BuildContext context) {
    print('ZindRouteDelegate build');
    String initialRoute = Navigator.defaultRouteName;
    if (this._routeModel != null) {
      print(this._routeModel.toJson());
      initialRoute = this._routeModel.url;
    }
    print('ZindRouteDelegate build: $initialRoute');
    return this._navigator;
  }

  void updatePage(ZindRouteModel routeModel) {
    _routeModel = routeModel;
    notifyListeners();
  }
}
