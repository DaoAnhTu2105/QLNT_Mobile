
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

abstract class LogoutRepository{
  final Uri logoutUrl = Uri.parse('https://qlnt-api.azurewebsites.net/api/auth/logout');

  Future<http.Response> logout(BuildContext context);
}
