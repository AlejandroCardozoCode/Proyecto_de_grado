import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _fireBaseToken = 'AIzaSyBGtSmyHIc-jvfnQqxlZ40SHtN3p7Q6HWI';

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _fireBaseToken});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = jsonDecode(resp.body);
    if (decodeResp.containsKey('idToken')) {
      //storage.write(key: 'idToken', value: decodeResp['idToken']);
      return decodeResp['localId'];
    } else {
      return decodeResp['error']['message'];
    }
  }

  Future<String?> loginUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {'key': _fireBaseToken});
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
