import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:restaurantes/global/environments.dart';
import 'package:restaurantes/models/login_response.dart';
import 'package:restaurantes/models/usuario.dart';

class AuthService with ChangeNotifier{
  //DECLARACION DE ATRIBUTOS
  late Usuario usuario;
  bool _autenticado = false;
  final _storage = new FlutterSecureStorage();

  //METODOS GET Y SET PARA SABER SI ESTA AUTENTICADO
  bool get autenticado => this._autenticado;

  set autenticado( bool valor){
    this._autenticado = valor;
    notifyListeners();
  }

  //METODOS PARA OBTENER Y BORRRAR EL TOKEN
  static Future<String?> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  //LOGIN ENVIO DE DATOS Y RECIBE TOKEN Y LO GUARDA
  Future<bool> login( String email, String password) async{
    this.autenticado = true;
    //Se ponen los datos que seran enviados como unjson
    final data = {
      'email': email,
      'pass' : password
    };

    final resp = await http.post(Uri.parse('${ Environment.apiUrl }/login/'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticado = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuarioDb;
      await this._guardarToken(loginResponse.token);
      return true;
    } else{
      return false;
    }

  }

  //METODO PARA REGISTRAR DATOS DEL USUARIO
  Future register(String nombre, String email, String password) async{
    this.autenticado = true;

    final data = {
      'nombre': nombre,
      'email' : email,
      'pass'  : password,
    };

    final resp = await http.post(Uri.parse('${ Environment.apiUrl }/login/new'),
      body: jsonEncode(data),
      headers: {
        'Content-type': 'application/json'
      }
    );

    this.autenticado = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuarioDb;
      await this._guardarToken(loginResponse.token);
      return true;
    } else{
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }


  }

  //METODO PARA CHECAR SI ESTA LOGEADO
  Future<bool> isLoggedIn() async{

    final token = await this._storage.read(key: 'token');

    final resp = await http.get(Uri.parse('${ Environment.apiUrl }/login/renew'),
      headers: {
        'Content-Type': 'application/json',
        'x-token'     : token.toString(),
      }
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuarioDb;
      await this._guardarToken(loginResponse.token);
      return true;
    } else{
      this.logout();
      return false;
    }
  }

  //GUARDAR TOKEN
  Future _guardarToken( String token) async{
    return await _storage.write(key: 'token', value: token);
  }

  //BORRAR EL TOKEN
  Future logout() async{
    return _storage.delete(key: 'token');
  }


}