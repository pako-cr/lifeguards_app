import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:lifeguards_app/models/server_error_response.dart';

import '../global/environment.dart';
import '../models/signin_response.dart';
import '../models/signup_response.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  User? user;
  bool _authInProgress = false;

  bool get authInProgress => this._authInProgress;

  set authInProgress(bool inProgress) {
    this._authInProgress = inProgress;
    notifyListeners();
  }

  final _storage = new FlutterSecureStorage();

  static Future<String?> getToken() async {
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> logout() async {
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future signUp(String email, String password) async {
    try {
      this._authInProgress = true;
      notifyListeners();

      final data = {'email': email, 'password': password};

      var uri = Uri.http('${Environment.apiUrl}', '/api/auth/signup/');

      final resp = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      this._authInProgress = false;
      notifyListeners();

      if (resp.body.contains('"ok":false')) {
        final serverErrorResponse = serverErrorResponseFromJson(resp.body);
        return {'result': false, 'msg': serverErrorResponse.error.message};
      } else {
        if (resp.statusCode == 200) {
          final signUpResponse = signUpResponseFromJson(resp.body);
          this.user = signUpResponse.user;
          await this._saveToken(signUpResponse.token);

          return {'result': true, 'msg': ''};
        }

        return {
          'result': false,
          'msg':
              'Unknown error. Please try again. If the problem persist please contact the administrator.'
        };
      }
    } catch (ex) {
      print('❌ [Services] [AuthService] [SignUp] Error occurred. Detail: $ex');
      return {
        'result': false,
        'msg':
            'Connection to server failed. Please check if the device is connected to internet.'
      };
    }
  }

  Future signIn(String email, String password) async {
    try {
      this._authInProgress = true;
      notifyListeners();

      final data = {'email': email, 'password': password};

      var uri = Uri.http('${Environment.apiUrl}', '/api/auth/signin/');

      final resp = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {'Content-Type': 'application/json'},
      );

      this._authInProgress = false;
      notifyListeners();

      if (resp.body.contains('"ok":false')) {
        final serverErrorResponse = serverErrorResponseFromJson(resp.body);
        return {'result': false, 'msg': serverErrorResponse.error.message};
      } else {
        final signInResponse = signInResponseFromJson(resp.body);

        if (resp.statusCode == 200) {
          this.user = signInResponse?.user;
          await this._saveToken(signInResponse?.token ?? '');

          return {'result': true, 'msg': ''};
        }

        return {
          'result': false,
          'msg':
              'Unknown error. Please try again. If the problem persist please contact the administrator.'
        };
      }
    } catch (ex) {
      print('❌ [Services] [AuthService] [SignIn] Error occurred. Detail: $ex');
      return {
        'result': false,
        'msg':
            'Connection to server failed. Please check if the device is connected to internet.'
      };
    }
  }

  Future isLogedIn() async {
    try {
      final token = await this._storage.read(key: 'token');

      var uri = Uri.http('${Environment.apiUrl}', '/api/auth/renew/');

      final resp = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'x-token': token ?? '',
        },
      );

      this._authInProgress = false;
      notifyListeners();

      // TODO: here

      if (resp.statusCode == 200) {
        final signInResponse = signInResponseFromJson(resp.body);
        this.user = signInResponse?.user;
        await this._saveToken(signInResponse?.token ?? '');

        return true;
      }

      this.deleteToken();
      return false;
    } catch (ex) {
      print(
          '❌ [Services] [AuthService] [IsLogedIn] Error occurred. The connection to server probably failed. Detail: $ex');
      return false;
    }
  }

  Future _saveToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future deleteToken() {
    // Delete value
    return this._storage.delete(key: 'token');
  }
}
