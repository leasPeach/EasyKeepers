import 'package:easy_keepers/pages/budget_page.dart';
import 'package:easy_keepers/pages/chart_page.dart';
import 'package:easy_keepers/pages/detail_page.dart';
import 'package:easy_keepers/pages/mine_page.dart';
import 'package:flutter/material.dart';

class BottomTabScreen extends StatefulWidget {
  const BottomTabScreen({Key? key}) : super(key: key);

  @override
    State<BottomTabScreen> createState() => _BottomTabScreenState();
}

class _BottomTabScreenState extends State<BottomTabScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: [
          _barItem(isSelected: currentIndex == 0, titleStr: 'Detail'),
          _barItem(isSelected: currentIndex == 1, titleStr: 'Chart'),
          _barItem(isSelected: currentIndex == 2, titleStr: 'Budget'),
          _barItem(isSelected: currentIndex == 3, titleStr: 'Mine'),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          DetailPage(),
          ChartHomePage(),
          BudgetPage(),
          UserCenterScreen(),
        ],
      ),
    );
  }

  BottomNavigationBarItem _barItem(
      {required String titleStr, required bool isSelected}) {
    TextStyle style;
    if (isSelected == true) {
      style = const TextStyle(color: Color(0xFF347AF6), fontSize: 16);
    } else {
      style = const TextStyle(color: Color(0xFF777777), fontSize: 16);
    }
    return BottomNavigationBarItem(
      label: '',
      icon: Text(
        titleStr,
        style: style,
      ),
    );
  }
}
