import 'package:flutter/material.dart';

class DefultData {
  static const List<String> state = ['income', 'outcome'];
  static const List<String> type_0 = ['wage', 'wealth management', 'other'];
  static const List<String> type_1 = [
    'mall shopping',
    'meeting',
    'online shopping',
    'house loan',
    'auto loan',
    'other',
  ];

  static List<ClassifyModel> classifyOut = [
    ClassifyModel(icon: Icons.breakfast_dining, name: '餐饮', id: '1'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '日用', id: '2'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '购物', id: '3'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '交通', id: '4'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '蔬菜', id: '5'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '水果', id: '6'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '零食', id: '7'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '运动', id: '8'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '医疗', id: '9'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '汽车', id: '10'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '学习', id: '11'),
  ];

    static List<ClassifyModel> classifyIn = [
    ClassifyModel(icon: Icons.breakfast_dining, name: '工资', id: '101'),
    ClassifyModel(icon: Icons.breakfast_dining, name: 'income', id: '102'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '理财', id: '103'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '礼金', id: '104'),
    ClassifyModel(icon: Icons.breakfast_dining, name: '其他', id: '105'),
  ];

  ///////mark: 可以随意添加类型，但是，classifyOut 和 classifyIn 里面的 id 不能重复
}

class ClassifyModel {
  String id;
  String name;
  IconData icon;
  ClassifyModel({
    required this.name,
    required this.icon,
    required this.id
  });
}
