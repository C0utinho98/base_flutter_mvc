import 'package:base/app/controllers/auth/auth_service.dart';
import 'package:base/app/views/pages/auth_screen.dart';
import 'package:base/app/views/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController auth = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return auth.isAuth ? HomeScreen() : AuthScreen();
        }
      },
    );
  }
}
