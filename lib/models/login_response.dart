// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

import 'package:restaurantes/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        required this.ok,
        required this.usuarioDb,
        required this.token,
    });

    bool ok;
    Usuario usuarioDb;
    String token;

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"],
        usuarioDb: Usuario.fromJson(json["usuarioDB"]),
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarioDB": usuarioDb.toJson(),
        "token": token,
    };
}

