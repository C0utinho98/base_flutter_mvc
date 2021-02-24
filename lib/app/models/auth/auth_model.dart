import 'dart:async';

class Auth {
  String userId;
  String token;
  DateTime expiryDate;
  Timer logoutTimer;
}
