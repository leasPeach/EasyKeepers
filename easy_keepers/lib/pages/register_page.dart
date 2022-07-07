import 'package:easy_keepers/helper.dart';
import 'package:easy_keepers/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pattern_locker/flutter_pattern_locker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String tip = 'Please set password';
  String subTip = '';
  LockConfig config = LockConfig();
  String? pwd;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.build(context, 'Register', showLeft: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(tip, style: const TextStyle(fontSize: 16)),
            Text(subTip),
            PatternLocker(
              config: config,
              style: const LockStyle(
                  defaultColor: Colors.grey, selectedColor: Colors.blue),
              onStart: () {
                setState(() {
                  subTip = '';
                  config.isError = false;
                  config.isKeepTrackOnComplete = false;
                  if (tip == "Set the password again") {
                    config.isKeepTrackOnComplete = true;
                  }
                });
              },
              onComplete: (pwd, length) {
                if (this.pwd == null) {
                  if (length < 4) {
                    setState(() {
                      subTip = 'The password is connected to at least 4 points';
                      config.isError = true;
                      config.isKeepTrackOnComplete = true;
                    });
                  } else {
                    this.pwd = pwd;
                    setState(() {
                      tip = "Set the password again";
                    });
                  }
                } else {
                  if (this.pwd != pwd) {
                    setState(() {
                      config.isError = true;
                      subTip = 'The trajectories of the two slides are inconsistent';
                    });
                  } else {
                    setState(() {
                      tip = '';
                      subTip = 'success';
                      config.isKeepTrackOnComplete = false;
                    });
                    _success();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _success() {
    User.savePwd(pwd!);
  }
}
