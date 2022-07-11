import 'dart:async';

import 'package:easy_keepers/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pattern_locker/flutter_pattern_locker.dart';

import '../storage_manager.dart';
import 'main_tabbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String tip = 'Please enter your password';
  LockConfig config = LockConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.build(context, 'Login', showLeft: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(tip, style: const TextStyle(fontSize: 16)),
            PatternLocker(
              config: config,
              style: const LockStyle(
                  defaultColor: Colors.grey, selectedColor: Colors.blue),
              onStart: () {},
              onComplete: (pwd, length) {
                _click(pwd);
              },
            ),
          ],
        ),
      ),
    );
  }

  _click(String pwd) {
    if (pwd == User.getPwd()) {
      setState(() {
        tip = 'success!';
      });

      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (BuildContext context) {
          return const BottomTabScreen();
        },
      ), (route) => false);
    } else {
      setState(() {
        tip = 'wrong password!!!!';
      });
    }
  }
}
