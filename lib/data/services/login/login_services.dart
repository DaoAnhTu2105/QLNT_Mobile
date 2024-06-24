import 'dart:convert';
import 'package:learn_flutter/data/repository/login_repository/login_repository.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginServices implements LoginRepository{
  @override
  final Uri loginUrl = Uri.parse('https://qlnt-api.azurewebsites.net/api/auth/staff/login');
  @override
  Future<bool> login(String username, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(loginUrl, headers: {
     'Content-Type': 'application/json'
    }, body: jsonEncode({'username': username, 'password': password}));
    try{
      if(response.statusCode == 200){
        var cookie = response.headers['set-cookie'];
        if (cookie != null) {
          var prefCookie = pref.getString('user');
          if (prefCookie != null) {
            pref.remove('user');
            pref.remove('user-name');
            pref.remove('role');
            pref.remove('avatar');
          }
          var body = utf8.decode(response.bodyBytes);

          var bodyWrapper = jsonDecode(body) as Map;
          await _setCookie(pref, cookie, bodyWrapper['name'], bodyWrapper['role'],
              bodyWrapper['avatar']);
          return true;
        } else {
          return false;
        }
      }else if(response.statusCode == 400 || response.statusCode == 500){
        print("That bai ${response.statusCode}");
        return false;
      }else{
        print("That bai ${response.statusCode}");
        return false;
      }
    }catch(e){
      throw Exception('Lỗi Login');
    }
  }
}

Future _setCookie(SharedPreferences pref, String cookie, String name,
    String role, String avatar) async {
  await pref.setString('user', cookie);
  await pref.setString('user-name', name);
  await pref.setString('role', role);
  await pref.setString('avatar', avatar);
}

class AuthServices implements CheckAuth{
  @override
  final Uri checkAuthUrl = Uri.parse('https://qlnt-api.azurewebsites.net/api/auth/check-auth');

  @override
  Future<http.Response> checkAuth() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(checkAuthUrl, headers: {'Content-Type': 'application/json', 'Cookie': pref.getString('user')!});
    try{
      if(response.statusCode == 200){
        print("Thanh cong ${response.statusCode}");

      }else if(response.statusCode == 400 || response.statusCode == 500){
        print("That bai ${response.statusCode}");
      }else{
        print("That bai ${response.statusCode}");
        print("That bai ${pref.get('user')} - ${pref.get('user-name')} - ${pref.get('role')} - ${pref.get('avatar')}");
      }
    }catch(e){
      throw Exception('Lỗi Cookie');
    }
    return response;
  }
}