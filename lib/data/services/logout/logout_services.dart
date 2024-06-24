
import 'package:flutter/material.dart';
import 'package:learn_flutter/ui/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../repository/logout_repository/logout_repository.dart';
import 'package:http/http.dart' as http;
class LogoutServices implements LogoutRepository{
  @override
  final Uri logoutUrl = Uri.parse('https://qlnt-api.azurewebsites.net/api/auth/logout');
  @override
  Future<http.Response> logout(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(logoutUrl, headers: {'Content-Type': 'application/json', 'Cookie': pref.getString('user')!});
    try{
      if(response.statusCode == 200){
        _removeCookie();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login(title: 'Login',)),
        );
      }else if(response.statusCode == 400 || response.statusCode == 500){
        print('Lỗi logout ${response.statusCode}');
      }else {
        print('Lỗi logout ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Lỗi Logout');
    }
    return response;
  }
}

Future<void> _removeCookie() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove('user');
  pref.remove('user-name');
  pref.remove('role');
  pref.remove('avatar');
}