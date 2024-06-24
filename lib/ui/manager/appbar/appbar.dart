import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppbarApp extends StatelessWidget implements PreferredSizeWidget {
  final String titleAppbar;

  const AppbarApp({super.key, required this.titleAppbar});

  Future<String?> getAvatar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('avatar');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      leading: titleAppbar != 'Home page' && titleAppbar != 'Account'
          ? Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: IconButton(
                  icon: const Icon(Icons.keyboard_backspace),
                  color: Colors.white,
                  iconSize: 35,
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            )
          : const Text(""),
      title: Text(
        titleAppbar,
        style: const TextStyle(
            fontFamily: 'Dosis',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue[700],
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: IconButton(
            icon: const Icon(Icons.circle_notifications),
            color: Colors.white,
            iconSize: 35.0,
            onPressed: () {
              print("Đã nhấn vào  thông báo");
            },
          ),
        )
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
