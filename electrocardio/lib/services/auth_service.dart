import 'dart:convert';

import 'package:electrocardio/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    KeyService keyService = KeyService();
    final url = Uri.https(await keyService.obtainAuthUrl(), '/v1/accounts:signUp', {'key': await keyService.obtainFireBaseToken()});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = jsonDecode(resp.body);
    if (decodeResp.containsKey('idToken')) {
      //storage.write(key: 'idToken', value: decodeResp['idToken']);
      return decodeResp['localId'];
    } else {
      return "";
    }
  }

  Future<String?> loginUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    KeyService keyService = KeyService();
    final url = Uri.https(await keyService.obtainAuthUrl(), '/v1/accounts:signInWithPassword', {'key': await keyService.obtainFireBaseToken()});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = jsonDecode(resp.body);
    if (decodeResp.containsKey('idToken')) {
      //storage.write(key: 'idToken', value: decodeResp['idToken']);
      return decodeResp['localId'];
    } else {
      return decodeResp['error']['message'];
    }
  }
}
