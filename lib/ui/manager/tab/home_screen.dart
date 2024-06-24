import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter/data/services/logout/logout_services.dart';
import 'package:learn_flutter/ui/manager/appbar/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/services/login/login_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var checkAuth = AuthServices();
  var logout = LogoutServices();

  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      appBar: const AppbarApp(titleAppbar: 'Home page',),
      body: Center(child: Column(
        children: <Widget>[
          const Center(child: Text('Home Screen')),
          TextButton(onPressed: () {
            checkAuth.checkAuth();
          }, child: const Text(
            'Check Auth'
          )),
          TextButton(onPressed: () {
            logout.logout(context);
          }, child: const Text(
              'Logout'
          )),
        ],
      ),),
    ));
  }
}
