import 'package:shared_preferences/shared_preferences.dart';

const PWDKEY = 'pwdKey';

class StorageManager {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}

class User {
  static savePwd(String pwd) {
    StorageManager.sharedPreferences?.setString(PWDKEY, pwd);
  }

  static String? getPwd() {
    return StorageManager.sharedPreferences?.getString(PWDKEY);
  }
}
