import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:cotopaxi/models/user.dart';
import 'package:cotopaxi/global/enviroment.dart';
import 'package:cotopaxi/models/login_response.dart';

class AuthService with ChangeNotifier {
  User usuario;
  bool _sending = false;

  final _storage = new FlutterSecureStorage();

  bool get sennding => this._sending;
  set sennding(bool value) {
    this._sending = value;
    notifyListeners();
  }

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.sennding = true;
    final data = {'email': email, 'password': password};
    final resp = await http.post('${Environment.apiUrl}/login',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    this.sennding = false;
    if (resp.statusCode == 200) {
      final loginResp = loginResponseFromJson(resp.body);
      this.usuario = loginResp.usuario;
      this._guardarToken(loginResp.token);
      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    this.sennding = true;
    final data = {'nombre': nombre, 'email': email, 'password': password};
    final resp = await http.post('${Environment.apiUrl}/login/new',
        body: jsonEncode(data), headers: {'Content-Type': 'application/json'});
    print(resp.body);
    this.sennding = false;
    if (resp.statusCode == 200) {
      final loginResp = loginResponseFromJson(resp.body);
      this.usuario = loginResp.usuario;
      this._guardarToken(loginResp.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

 Future isLoggedIn() async {
   final token = await this._storage.read(key: 'token');
  final resp = await http.get('${ Environment.apiUrl }/login/renew', 
      headers: { 
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if ( resp.statusCode == 200 ) {
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logOut();
      return false;
    }
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut() async {
    return await _storage.delete(key: 'token');
  }
}
