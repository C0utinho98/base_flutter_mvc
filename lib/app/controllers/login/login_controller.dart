import 'package:base/app/controllers/auth/auth_controller.dart';
import 'package:base/app/models/login/login_model.dart';
import 'package:base/app/shared/enums/auth_mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginController {
  final login = Login();
  TextEditingController passwordController = TextEditingController();

  final BuildContext context;

  LoginController({this.context});

  GlobalKey<FormState> formKey = GlobalKey();

  setEmail(String value) => login.email = value;
  setPassword(String value) => login.password = value;

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro !'),
        content: Text(msg),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Fechar'),
          ),
        ],
      ),
    );
  }

  String validationEmail(String email) {
    if (email.isEmpty) {
      return "Informe um e-mail válido!";
    }
    return null;
  }

  String validationPassword(String password) {
    if (password.isEmpty) {
      return "Informe uma senha válido!";
    } else if (password.length < 6) {
      return "Senha precisa ter no minimo 6 caracteres!";
    }
    return null;
  }

  String validationComparePassword(String password) {
    if (password != passwordController.text) {
      return "Senhas sao diferentes";
    }
    return null;
  }

  void submit(AuthMode authMode) async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();

    final auth = Provider.of<AuthController>(context, listen: false);
    login.changeLoading();

    try {
      if (authMode == AuthMode.Login) {
        await auth.login(
          login.email,
          login.password,
        );
      } else {
        await auth.singup(
          login.email,
          login.password,
        );
      }
    } catch (erro) {
      _showErrorDialog("Ocorreu um erro inesperado !");
    }

    login.changeLoading();
  }
}
