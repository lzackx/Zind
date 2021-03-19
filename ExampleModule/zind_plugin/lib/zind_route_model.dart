// To parse this JSON data, do
//
//     final zindRouteModel = zindRouteModelFromMap(jsonString);

import 'dart:convert';

class ZindRouteModel {
  ZindRouteModel({
    this.url,
    this.parameters,
  });

  String url;
  Parameters parameters;

  factory ZindRouteModel.fromJson(String str) => ZindRouteModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ZindRouteModel.fromMap(Map<String, dynamic> json) => ZindRouteModel(
        url: json["url"] == null ? null : json["url"],
        parameters: json["parameters"] == null ? null : Parameters.fromMap(json["parameters"]),
      );

  Map<String, dynamic> toMap() => {
        "url": url == null ? null : url,
        "parameters": parameters == null ? null : parameters.toMap(),
      };
}

class Parameters {
  Parameters({
    this.public,
    this.private,
  });

  Public public;
  Private private;

  factory Parameters.fromJson(String str) => Parameters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Parameters.fromMap(Map<String, dynamic> json) => Parameters(
        public: json["public"] == null ? null : Public.fromMap(json["public"]),
        private: json["private"] == null ? null : Private.fromMap(json["private"]),
      );

  Map<String, dynamic> toMap() => {
        "public": public == null ? null : public.toMap(),
        "private": private == null ? null : private.toMap(),
      };
}

class Private {
  Private();

  factory Private.fromJson(String str) => Private.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Private.fromMap(Map<String, dynamic> json) => Private();

  Map<String, dynamic> toMap() => {};
}

class Public {
  Public({
    this.ver,
    this.muid,
    this.source,
    this.sysVer,
    this.sysType,
    this.ua,
    this.isDev,
    this.channel,
    this.safeareaTop,
    this.safeareaBottom,
  });

  String ver;
  String muid;
  String source;
  String sysVer;
  String sysType;
  String ua;
  String isDev;
  String channel;
  int safeareaTop;
  int safeareaBottom;

  factory Public.fromJson(String str) => Public.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Public.fromMap(Map<String, dynamic> json) => Public(
        ver: json["_ver"] == null ? null : json["_ver"],
        muid: json["_muid"] == null ? null : json["_muid"],
        source: json["_source"] == null ? null : json["_source"],
        sysVer: json["_sys_ver"] == null ? null : json["_sys_ver"],
        sysType: json["_sys_type"] == null ? null : json["_sys_type"],
        ua: json["_ua"] == null ? null : json["_ua"],
        isDev: json["_isDev"] == null ? null : json["_isDev"],
        channel: json["_channel"] == null ? null : json["_channel"],
        safeareaTop: json["_safearea_top"] == null ? null : json["_safearea_top"],
        safeareaBottom: json["_safearea_bottom"] == null ? null : json["_safearea_bottom"],
      );

  Map<String, dynamic> toMap() => {
        "_ver": ver == null ? null : ver,
        "_muid": muid == null ? null : muid,
        "_source": source == null ? null : source,
        "_sys_ver": sysVer == null ? null : sysVer,
        "_sys_type": sysType == null ? null : sysType,
        "_ua": ua == null ? null : ua,
        "_isDev": isDev == null ? null : isDev,
        "_channel": channel == null ? null : channel,
        "_safearea_top": safeareaTop == null ? null : safeareaTop,
        "_safearea_bottom": safeareaBottom == null ? null : safeareaBottom,
      };
}
