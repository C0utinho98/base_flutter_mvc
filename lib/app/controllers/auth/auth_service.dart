import 'dart:async';
import 'package:base/app/models/auth/auth_model.dart';
import 'package:base/app/repositories/auth_repository.dart';
import 'package:base/app/shared/local_storage/local_storage.dart';
import 'package:flutter/material.dart';

class AuthController with ChangeNotifier {
  Auth _auth = Auth();
  AuthRepository _http = AuthRepository();

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return isAuth ? _auth.userId : null;
  }

  String get token {
    if (_auth.token != null &&
        _auth.expiryDate != null &&
        _auth.expiryDate.isAfter(DateTime.now())) {
      return _auth.token;
    } else {
      return null;
    }
  }

  void _authentication(Map<String, dynamic> responseBody) {
    _auth.token = responseBody["idToken"];
    _auth.userId = responseBody["localId"];
    _auth.token = responseBody["idToken"];
    _auth.userId = responseBody["localId"];
    _auth.expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(responseBody["expiresIn"]),
      ),
    );

    LocalStorage.saveMap('userData', {
      "token": _auth.token,
      "userId": _auth.userId,
      "expiryDate": _auth.expiryDate.toIso8601String(),
    });

    _autoLogout();
    notifyListeners();
  }

  Future<void> singup(String email, String password) async {
    final response = await _http.authenticate(
      email,
      password,
      "signUp",
    );
    _authentication(response);
  }

  Future<void> login(String email, String password) async {
    final response = await _http.authenticate(
      email,
      password,
      "signInWithPassword",
    );
    _authentication(response);
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      return Future.value();
    }

    final userData = await LocalStorage.getMap('userData');

    if (userData == null) {
      return Future.value();
    }

    final expiryDate = DateTime.parse(userData["expiryDate"]);

    if (expiryDate.isBefore(DateTime.now())) {
      return Future.value();
    }

    _auth.userId = userData["userId"];
    _auth.token = userData["token"];
    _auth.expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
    return Future.value();
  }

  void logout() {
    _auth.token = null;
    _auth.userId = null;
    _auth.expiryDate = null;
    if (_auth.logoutTimer != null) {
      _auth.logoutTimer.cancel();
      _auth.logoutTimer = null;
    }
    LocalStorage.remove('userData');
    notifyListeners();
  }

  void _autoLogout() {
    if (_auth.logoutTimer != null) {
      _auth.logoutTimer.cancel();
    }
    final timeToLogout = _auth.expiryDate.difference(DateTime.now()).inSeconds;
    _auth.logoutTimer = Timer(Duration(seconds: timeToLogout), logout);
  }
}
