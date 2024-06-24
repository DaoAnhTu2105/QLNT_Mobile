

import 'package:http/http.dart' as http;
import 'package:learn_flutter/data/model/staff.dart';

abstract class LoginRepository{
  final Uri loginUrl = Uri.parse('https://qlnt-api.azurewebsites.net/api/auth/staff/login');

  Future<bool> login(String username, String password);
}

abstract class CheckAuth{
  final Uri checkAuthUrl = Uri.parse('https://qlnt-api.azurewebsites.net/api/auth/check-auth');

  Future<http.Response> checkAuth();
}