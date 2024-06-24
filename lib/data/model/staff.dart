import 'package:http/src/response.dart';

class StaffInfo {
  StaffInfo(this.staffId, this.fullName, this.phoneNumber, this.username,
      this.dateOfBirth,this.avatar);

  String? staffId;
  String? fullName;
  String? phoneNumber;
  String? avatar;
  String? username;
  DateTime? dateOfBirth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StaffInfo &&
              runtimeType == other.runtimeType &&
              staffId == other.staffId;

  @override
  int get hashCode => staffId.hashCode;

  factory StaffInfo.fromJson(Map<String, dynamic> map) {
    return StaffInfo(map['staffId'], map['fullName'], map['phoneNumber'],
        map['username'], DateTime.parse(map['dateOfBirth']),map['avatar']);
  }
}