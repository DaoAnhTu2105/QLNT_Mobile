import 'package:http/http.dart' as http;
import 'package:learn_flutter/data/model/staff.dart';

abstract class StaffRepository{
  final Uri getStaffUrl = Uri.parse('https://qlnt-api.azurewebsites.net/api/auth/get-info');

  Future<StaffInfo> getStaffInfo();
}