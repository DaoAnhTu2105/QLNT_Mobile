import 'package:flutter/material.dart';
import 'package:learn_flutter/data/model/staff.dart';
import 'package:learn_flutter/data/services/staff/staff_services.dart';
import 'package:learn_flutter/ui/manager/appbar/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final _profileForm = GlobalKey<FormState>();
  late final getStaff = StaffServices();
  late Future<StaffInfo> getStaffInfo;
  bool loading = true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  TextEditingController dateCtl = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  Future<void> getDataStaff() async{
    getStaffInfo =  getStaff.getStaffInfo();
    getStaffInfo.then((staffInfo) {
      setState(() {
        fullname.text = staffInfo.fullName!;
        username.text = staffInfo.username!;
        phoneNumber.text = staffInfo.phoneNumber!;
        dateCtl.text = staffInfo.dateOfBirth != null
            ? staffInfo.dateOfBirth!.toLocal().toString().split(' ')[0]
            : DateTime.now().toLocal().toString().split(' ')[0];
      });
    }).then((value) {
      loading = false;
    }).catchError((error) {
      print("Error getting staff info: $error");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataStaff();
  }

  Future _onRefresh() async {
    try {
      _refreshIndicatorKey.currentState?.show();
      getDataStaff();
    } catch (e) {
      print("Error getting staff info: $e");
    }
  }

  Future<String> getAvatar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('avatar') ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppbarApp(titleAppbar: "Account"),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                    child: Form(
                        key: _profileForm,
                        child: Column(
                          children: [
                            FutureBuilder<String>(
                              future: getAvatar(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(); // Show a loading indicator while waiting
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  return Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(top: 30),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              220,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              220,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Colors.blue, width: 4),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    snapshot.data!),
                                                fit: BoxFit.cover),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Container(
                                                margin: const EdgeInsets.only(
                                                    right: 20),
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100)),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 20, right: 20, left: 20),
                              child: Center(
                                child: Text(
                                  "Thông tin cá nhân",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Dosis",
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, left: 20),
                              child: SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: username,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.person_rounded,
                                      size: 35,
                                    ),
                                    hintText: 'Ex: nguyenvana',
                                    labelText: 'Tên tài khoản *',
                                  ),
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'Tên tài khoản không được bỏ trống!';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, left: 20),
                              child: SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: fullname,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.face,
                                      size: 35,
                                    ),
                                    hintText: 'Ex: Nguyễn Văn A',
                                    labelText: 'Họ và tên *',
                                  ),
                                  validator: (String? value) {
                                    // RegExp regex = RegExp(
                                    //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    // else if (!regex.hasMatch(value)) {
                                    // return 'Họ và tên yêu cầu chữ hoa, số và ký tự đặc biệt!';
                                    // }
                                    if (value == null) {
                                      return 'Họ và tên không được bỏ trống!';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, left: 20),
                              child: SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: phoneNumber,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.phone,
                                      size: 35,
                                    ),
                                    hintText: 'Ex: 111 111 1111',
                                    labelText: 'Số điện thoại *',
                                  ),
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'Số điện thoại không được bỏ trống!';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20, right: 20, left: 20),
                              child: SizedBox(
                                width: 350,
                                child: TextFormField(
                                  controller: dateCtl,
                                  onTap: () async {
                                    DateTime? date = DateTime(1900);
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());

                                    date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2100),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: const ColorScheme.light(
                                              primary: Colors.blue,
                                              // header background color
                                              onPrimary: Colors
                                                  .white, // header text color
                                            ),
                                            textButtonTheme:
                                                TextButtonThemeData(
                                              style: TextButton.styleFrom(
                                                foregroundColor: Colors
                                                    .blue, // button text color
                                              ),
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    dateCtl.text = date!.toIso8601String();
                                  },
                                  decoration: const InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_month,
                                      size: 35,
                                    ),
                                    hintText: 'Ex: 01-01-1000',
                                    labelText: 'Ngày sinh *',
                                  ),
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'Ngày sinh không được bỏ trống!';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30, right: 20, left: 20),
                              child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blue[600]),
                                ),
                                onPressed: () {},
                                child: const SizedBox(
                                  width: 140,
                                  child: Center(
                                    child: Text(
                                      'Cập nhật',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontFamily: "Dosis"),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )))),
      ),
    );
  }
}
