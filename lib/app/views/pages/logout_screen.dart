import 'package:base/app/controllers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogoutScreenExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Sair'),
          onPressed: () {
            Provider.of<AuthController>(context, listen: false).logout();
          },
        ),
      ),
    );
  }
}
