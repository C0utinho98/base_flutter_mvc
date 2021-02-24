import 'dart:convert';
import 'package:base/app/shared/constants/api_routes.dart';
import 'package:base/app/shared/constants/keys.dart';
import 'package:base/app/shared/exceptions/http_exception.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<Map<String, dynamic>> authenticate(
    String email,
    String password,
    String urlSegment,
  ) async {
    final _url = '${ApiRoutes.BASE_API_URL}$urlSegment?key=${Key.FIREBASE_KEY}';

    final response = await http.post(
      _url,
      body: json.encode({
        "email": email,
        "password": password,
        "returnSecureToken": true,
      }),
    );

    final responseBody = json.decode(response.body);
    if (responseBody["error"] != null) {
      throw HttpException('Erro ao realizar operação!');
    } else {
      return responseBody;
    }
  }
}
