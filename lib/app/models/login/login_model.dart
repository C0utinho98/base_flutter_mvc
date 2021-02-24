import 'package:mobx/mobx.dart';
part 'login_model.g.dart';

class Login = _LoginBase with _$Login;

abstract class _LoginBase with Store {
  String email;
  String password;

  @observable
  bool loading = false;

  @action
  changeLoading() => loading = !loading;
}
