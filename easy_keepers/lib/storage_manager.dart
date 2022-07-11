import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'source/source.dart';

const pwdKey = 'pwdKey';
const billKey = 'Bill_key';

class StorageManager {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}

class User {
  static savePwd(String pwd) {
    StorageManager.sharedPreferences?.setString(pwdKey, pwd);
  }

  static String? getPwd() {
    return StorageManager.sharedPreferences?.getString(pwdKey);
  }
}

//// ...
class Bill {
  //save
  static Future<bool> save(
      {required String amount,
      required String type,
      required String time,
      required String classify,
      String? remark}) async {
    Map<String, String> data = {
      "amount": amount,
      "type": type,
      'time': time,
      'classify': classify,
      'remark': remark ?? ''
    };
    var origin = getList();
    origin.add(data);
    try {
      var flag = await StorageManager.sharedPreferences
          ?.setString(billKey, jsonEncode(origin));
      return flag ?? false;
    } catch (_) {
      return false;
    }
  }

  //list
  static List getList() {
    List temp = [];
    var json = StorageManager.sharedPreferences?.getString(billKey);
    if (json != null) {
      temp = jsonDecode(json);
    }
    return temp;
  }

  static double getIncome() {
    double come = 0.0;
    for (var element in getList()) {
      double num = double.tryParse(element['amount']) ?? 0.0;
      if (element['type'] == '0') {
        come += num;
      }
    }
    return come;
  }

  static double getOutcome() {
    double out = 0.0;
    for (var element in getList()) {
      double num = double.tryParse(element['amount']) ?? 0.0;
      if (element['type'] == '1') {
        out += num;
      }
    }
    return out;
  }

  //statistics

  //近4年的
  static List<ChartModel> getYear({required String type}) {
    double n_2022 = 0;
    double n_2021 = 0;
    double n_2020 = 0;
    double n_2019 = 0;
    List temp = getList();

    for (var element in temp) {
      try {
        if (element['type'] == type) {
          String timeStr = element['time'];
          String y = timeStr.substring(0, 4);
          switch (y) {
            case '2022':
              n_2022 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '2021':
              n_2022 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '2020':
              n_2022 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '2019':
              n_2022 += double.tryParse(element['amount']) ?? 0.0;
              break;
            default:
          }
        }
      } catch (_) {}
    }

    return [
      ChartModel(time: DateTime(2019), sales: n_2019),
      ChartModel(time: DateTime(2020), sales: n_2020),
      ChartModel(time: DateTime(2021), sales: n_2021),
      ChartModel(time: DateTime(2022), sales: n_2022),
    ];
  }

  static List<ChartModel> getMonth({required String type}) {
    double m_1 = 0;
    double m_2 = 0;
    double m_3 = 0;
    double m_4 = 0;
    double m_5 = 0;
    double m_6 = 0;
    double m_7 = 0;

    //getYear
    List temp = getList();

    for (var element in temp) {
      try {
        if (element['type'] == type) {
          String timeStr = element['time'];
          String m = timeStr.substring(5, 7);
          switch (m) {
            case '07':
              m_7 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '06':
              m_6 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '05':
              m_5 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '04':
              m_4 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '03':
              m_3 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '02':
              m_2 += double.tryParse(element['amount']) ?? 0.0;
              break;
            case '01':
              m_1 += double.tryParse(element['amount']) ?? 0.0;
              break;
            default:
          }
        }
      } catch (_) {}
    }
    return [
      ChartModel(time: DateTime(2022, 7), sales: m_7),
      ChartModel(time: DateTime(2022, 6), sales: m_6),
      ChartModel(time: DateTime(2022, 5), sales: m_5),
      ChartModel(time: DateTime(2022, 4), sales: m_4),
      ChartModel(time: DateTime(2022, 3), sales: m_3),
      ChartModel(time: DateTime(2022, 2), sales: m_2),
      ChartModel(time: DateTime(2022, 1), sales: m_1),
    ];
  }

  static List<ChartModel> getDay({required String type}) {
    final dateFormat = DateFormat("yyyy-MM-dd");
    var now = DateTime.now();
    var now_0 = dateFormat.format(now);
    var now_1 = dateFormat.format(now.subtract(const Duration(days: 1)));
    var now_2 = dateFormat.format(now.subtract(const Duration(days: 2)));
    var now_3 = dateFormat.format(now.subtract(const Duration(days: 3)));
    var now_4 = dateFormat.format(now.subtract(const Duration(days: 4)));
    var now_5 = dateFormat.format(now.subtract(const Duration(days: 5)));
    var now_6 = dateFormat.format(now.subtract(const Duration(days: 6)));

    double a_0 = 0.0;
    double a_1 = 0.0;
    double a_2 = 0.0;
    double a_3 = 0.0;
    double a_4 = 0.0;
    double a_5 = 0.0;
    double a_6 = 0.0;

    List temp = getList();
    for (var element in temp) {
      try {
        if (element['type'] == type) {
          String timeStr = element['time'];
          String m = timeStr;
          if (m == now_0) {
            a_0 += double.tryParse(element['amount']) ?? 0.0;
          } else if (m == now_1) {
            a_1 += double.tryParse(element['amount']) ?? 0.0;
          } else if (m == now_2) {
            a_2 += double.tryParse(element['amount']) ?? 0.0;
          } else if (m == now_3) {
            a_3 += double.tryParse(element['amount']) ?? 0.0;
          } else if (m == now_4) {
            a_4 += double.tryParse(element['amount']) ?? 0.0;
          } else if (m == now_5) {
            a_5 += double.tryParse(element['amount']) ?? 0.0;
          } else if (m == now_6) {
            a_6 += double.tryParse(element['amount']) ?? 0.0;
          }
        }
      } catch (_) {}
    }
    return [
      ChartModel(
          time: DateTime.now().subtract(const Duration(days: 6)), sales: a_6),
      ChartModel(
          time: DateTime.now().subtract(const Duration(days: 5)), sales: a_5),
      ChartModel(
          time: DateTime.now().subtract(const Duration(days: 4)), sales: a_4),
      ChartModel(
          time: DateTime.now().subtract(const Duration(days: 3)), sales: a_3),
      ChartModel(
          time: DateTime.now().subtract(const Duration(days: 2)), sales: a_2),
      ChartModel(
          time: DateTime.now().subtract(const Duration(days: 1)), sales: a_1),
      ChartModel(time: DateTime.now(), sales: a_0),
    ];
  }

  static List<PieSales> getClass({required String type}) {
    List<PieSales> tempList = [];

    if (type == '1') {
      for (var element in DefultData.classifyOut) {
        double eT = 0.0;
        for (var item in getList()) {
          if (item['classify'] == element.id) {
            eT += double.tryParse(item['amount']) ?? 0.0;
          }
        }
        tempList.add(PieSales(element.name, eT));
      }
    } else {
      for (var element in DefultData.classifyIn) {
        double eT = 0.0;
        for (var item in getList()) {
          if (item['classify'] == element.id) {
            eT += double.tryParse(item['amount']) ?? 0.0;
          }
        }
        tempList.add(PieSales(element.name, eT));
      }
    }
    return tempList;
  }
}

class ChartModel {
  DateTime? time;
  int? index;
  double sales;
  ChartModel({this.time, this.index, required this.sales});
}

class PieSales {
  final String type;
  final double sales;
  PieSales(this.type, this.sales);
}
