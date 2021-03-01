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
        height: _authMode == AuthMode.Login
            ? deviceSize.height * 0.5
            : deviceSize.height * 0.6,
        width: deviceSize.width * 0.75,
        constraints: BoxConstraints(
          maxHeight: _authMode == AuthMode.Login ? 300 : 390,
        ),
        child: Form(
          key: _form.formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextFormField(
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => _form.validationEmail(value),
                onSaved: (value) => _form.setEmail(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                controller: _form.passwordController,
                validator: (value) => _form.validationPassword(value),
                onSaved: (value) => _form.setPassword(value),
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration: InputDecoration(labelText: 'Confirmar senha'),
                  obscureText: true,
                  validator: (value) => _form.validationComparePassword(value),
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
