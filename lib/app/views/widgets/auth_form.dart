import 'package:base/app/controllers/login/login_controller.dart';
import 'package:base/app/shared/enums/auth_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();

  void _switchMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginController _form = LoginController(context: context);

    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container(
        padding: EdgeInsets.all(16),
        height: _authMode == AuthMode.Login ? 290 : 371,
        width: deviceSize.width * 0.75,
        child: Form(
          key: _form.formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Informe um e-mail válido!";
                  }
                  return null;
                },
                onSaved: (value) => _form.setEmail(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Campo senha é obrigatório";
                  }
                  return null;
                },
                onSaved: (value) => _form.setPassword(value),
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirmar senha'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordController.text) {
                      return "Senhas sao diferentes";
                    }
                    return null;
                  },
                ),
              Spacer(),
              Observer(builder: (_) {
                if (_form.login.loading)
                  return CircularProgressIndicator();
                else
                  return RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 8.0,
                    ),
                    onPressed: () {
                      _form.submit(_authMode);
                    },
                    child: Text(
                        _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR'),
                  );
              }),
              FlatButton(
                onPressed: _switchMode,
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  _authMode == AuthMode.Login ? 'REGISTRAR' : 'LOGIN',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
