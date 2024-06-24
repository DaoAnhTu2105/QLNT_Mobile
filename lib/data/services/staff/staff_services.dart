import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:learn_flutter/data/model/staff.dart';
import 'package:learn_flutter/data/repository/staff_repository/staff_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StaffServices implements StaffRepository {
  @override
  // TODO: implement getStaffUrl
  Uri get getStaffUrl =>
      Uri.parse('https://qlnt-api.azurewebsites.net/api/auth/get-info');

  @override
  Future<StaffInfo> getStaffInfo() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.get(getStaffUrl, headers: {
      'Content-Type': 'application/json',
      'Cookie': pref.getString('user')!
    });

    if (response.statusCode == 200) {
      print("Lấy thông tin staff thành công");
      return StaffInfo.fromJson(
          jsonDecode(response.body) as Map<String, dynamic>);
    } else if (response.statusCode == 400 || response.statusCode == 500) {
      throw Exception('Failed to load data staff info: ${response.statusCode}');
    } else {
      throw Exception('Failed to load album');
    }
  }
}
