// To parse this JSON data, do
//
//     final zindRouteModel = zindRouteModelFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

class ZindRouteModel {
  ZindRouteModel({
    this.url,
    this.parameters,
  });

  String url;
  ZindParameters parameters;

  factory ZindRouteModel.fromJson(String str) => ZindRouteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZindRouteModel.fromMap(Map<String, dynamic> json) => ZindRouteModel(
        url: json["url"] == null ? null : json["url"],
        parameters: json["parameters"] == null ? null : ZindParameters.fromMap(json["parameters"]),
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
        "parameters": parameters == null ? null : parameters.toMap(),
      };

  factory ZindRouteModel.defaultModel() {
    String defaultJSON = """
    {\"url\":\"/\",\"parameters\":{\"public\":{\"router_type\":0,\"app\":\"\",\"environment\":0,\"muid\":\"\",\"platform\":\"\",\"safearea_top\":0,\"safearea_bottom\":0,\"version\":\"\",\"system_version\":\"\",\"ua\":\"\"},\"private\":{}}}
    """;
    return ZindRouteModel.fromJson(defaultJSON);
  }
}

class ZindParameters {
  ZindParameters({
    this.public,
    this.private,
  });

  ZindPublic public;
  ZindPrivate private;

  factory ZindParameters.fromJson(String str) => ZindParameters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZindParameters.fromMap(Map<String, dynamic> json) => ZindParameters(
        public: json["public"] == null ? null : ZindPublic.fromMap(json["public"]),
        private: json["private"] == null ? null : ZindPrivate.fromMap(json["private"]),
      );

  Map<String, dynamic> toMap() => {
        "public": public == null ? null : public.toMap(),
        "private": private == null ? null : private.toMap(),
      };
}

class ZindPrivate {
  ZindPrivate();

  factory ZindPrivate.fromJson(String str) => ZindPrivate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZindPrivate.fromMap(Map<String, dynamic> json) => ZindPrivate();

  Map<String, dynamic> toMap() => {};
}

class ZindPublic {
  ZindPublic({
    this.routerType,
    this.app,
    this.environment,
    this.muid,
    this.platform,
    this.safeareaTop,
    this.safeareaBottom,
    this.version,
    this.systemVersion,
    this.ua,
  });

  int routerType;
  String app;
  int environment;
  String muid;
  String platform;
  int safeareaTop;
  int safeareaBottom;
  String version;
  String systemVersion;
  String ua;

  factory ZindPublic.fromJson(String str) => ZindPublic.fromMap(json.decode(str));
  String toJson() => json.encode(toMap());
  factory ZindPublic.fromMap(Map<String, dynamic> json) => ZindPublic(
        routerType: json["router_type"] == null ? 0 : json["router_type"],
        app: json["app"] == null ? null : json["app"],
        environment: json["environment"] == null ? 1 : json["environment"],
        muid: json["muid"] == null ? null : json["muid"],
        platform: json["platform"] == null ? null : json["platform"],
        safeareaTop: json["safearea_top"] == null ? null : json["safearea_top"],
        safeareaBottom: json["safearea_bottom"] == null ? null : json["safearea_bottom"],
        version: json["version"] == null ? null : json["version"],
        systemVersion: json["system_version"] == null ? null : json["system_version"],
        ua: json["ua"] == null ? null : json["ua"],
      );
  Map<String, dynamic> toMap() => {
        "router_type": routerType == null ? 0 : routerType,
        "app": app == null ? null : app,
        "environment": environment == null ? 1 : environment,
        "muid": muid == null ? null : muid,
        "platform": platform == null ? null : platform,
        "safearea_top": safeareaTop == null ? 0 : safeareaTop,
        "safearea_bottom": safeareaBottom == null ? 0 : safeareaBottom,
        "version": version == null ? null : version,
        "system_version": systemVersion == null ? null : systemVersion,
        "ua": ua == null ? null : ua,
      };

  final List<String> _routerTypeSting = [
    "General", // 0
    "Shared",  // 1
    "PopUp",  // 2
    "Stack",  // 3
  ];
  String get currentRouterType => this._routerTypeSting[this.routerType];

  final List<String> _environment = [
    "debug",
    "release",
  ];
  String get currentEnvironment => this._environment[this.environment];
}
