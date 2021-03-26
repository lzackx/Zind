import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zind_plugin/zind_route_model.dart';

class ZindRouteInformationParser extends RouteInformationParser<ZindRouteModel> {
  @override
  Future<ZindRouteModel> parseRouteInformation(RouteInformation routeInformation) {
    print("parseRouteInformation: ${routeInformation.state} ${routeInformation.location}}");
    ZindRouteModel routeModel = ZindRouteModel.defaultModel();
    routeModel.url = routeInformation.location;
    // try {
    //   if (routeInformation.state != null) {
    //     print("parseRouteInformation: ZindRouteModel => ${routeInformation.state}");
    //     routeModel = ZindRouteModel.fromJson(routeInformation.state);
    //   }
    // } catch (e) {
    //   print("parseRouteInformation exception: $e");
    // }
    return SynchronousFuture(routeModel);
  }

  @override
  RouteInformation restoreRouteInformation(ZindRouteModel configuration) {
    print("restoreRouteInformation: ${configuration.toJson()}");
    return RouteInformation(location: configuration.url);
  }
}
