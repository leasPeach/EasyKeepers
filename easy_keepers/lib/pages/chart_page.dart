import 'package:easy_keepers/helper.dart';
import 'package:easy_keepers/pages/detail_page.dart';
import 'package:easy_keepers/storage_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

import 'analysis_page.dart';

class LinearSales {
  final DateTime year;
  final int sales;

  LinearSales(this.year, this.sales);
}

class ChartPage extends StatefulWidget {
  const ChartPage({Key? key}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  //当前选中的索引
  int _currentIndex = 0;

  Widget buildSegment() {
    return CupertinoSegmentedControl(
      padding: const EdgeInsets.only(top: 20),
      //子标签
      children: const <int, Widget>{
        0: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text("year"),
        ),
        1: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text("month"),
        ),
        2: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text("In seven days"),
        ),
      },
      //当前选中的索引
      groupValue: _currentIndex,
      //点击回调
      onValueChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      //选中的背景颜色
      selectedColor: AppColor.theme,
      //未选中的背景颜色
      unselectedColor: Colors.white,
      //边框颜色
      borderColor: AppColor.theme,
      //按下的颜色
      pressedColor: AppColor.theme.withOpacity(0.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSegment(),
        Expanded(
          child: _simpleLine(),
        ),
      ],
    );
  }

  Widget _simpleLine() {
    var data = [
      LinearSales(DateTime(2017, 9, 19), 10),
      LinearSales(DateTime(2017, 9, 20), 50),
      LinearSales(DateTime(2017, 9, 21), 500),
      LinearSales(DateTime(2017, 9, 22), 100),
    ];

    var seriesList = [
      charts.Series<LinearSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];

    // return charts.LineChart(seriesList, animate: false);

    if (_currentIndex == 0) {
      var monthList = [
        charts.Series<ChartModel, DateTime>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ChartModel sales, _) => sales.time ?? DateTime.now(),
          measureFn: (ChartModel sales, _) => sales.sales,
          data: Bill.getYear(type: '1'),
        )
      ];
      return charts.TimeSeriesChart(
        monthList,
        animate: true,
      );
    } else if (_currentIndex == 1) {
      var yearList = [
        charts.Series<ChartModel, DateTime>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ChartModel sales, _) => sales.time ?? DateTime.now(),
          measureFn: (ChartModel sales, _) => sales.sales,
          data: Bill.getMonth(type: '1'),
        )
      ];
      return charts.TimeSeriesChart(
        yearList,
        animate: true,
      );
    } else if (_currentIndex == 2) {
      var dayList = [
        charts.Series<ChartModel, DateTime>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ChartModel sales, _) => sales.time ?? DateTime.now(),
          measureFn: (ChartModel sales, _) => sales.sales,
          data: Bill.getDay(type: '1'),
        )
      ];
      return charts.TimeSeriesChart(
        dayList,
        animate: true,
      );
    }

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
    );
  }
}



class ChartPageTemp extends StatefulWidget {
  const ChartPageTemp({Key? key}) : super(key: key);

  @override
  State<ChartPageTemp> createState() => _ChartPageTempState();
}

class _ChartPageTempState extends State<ChartPageTemp> {
  //当前选中的索引
  int _currentIndex = 0;

  Widget buildSegment() {
    return CupertinoSegmentedControl(
      padding: const EdgeInsets.only(top: 20),
      //子标签
      children: const <int, Widget>{
        0: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text("year"),
        ),
        1: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text("month"),
        ),
        2: Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text("In seven days"),
        ),
      },
      //当前选中的索引
      groupValue: _currentIndex,
      //点击回调
      onValueChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      //选中的背景颜色
      selectedColor: AppColor.theme,
      //未选中的背景颜色
      unselectedColor: Colors.white,
      //边框颜色
      borderColor: AppColor.theme,
      //按下的颜色
      pressedColor: AppColor.theme.withOpacity(0.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSegment(),
        Expanded(
          child: _simpleLine(),
        ),
      ],
    );
  }

  Widget _simpleLine() {
    var data = [
      LinearSales(DateTime(2017, 9, 19), 10),
      LinearSales(DateTime(2017, 9, 20), 50),
      LinearSales(DateTime(2017, 9, 21), 500),
      LinearSales(DateTime(2017, 9, 22), 100),
    ];

    var seriesList = [
      charts.Series<LinearSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];

    // return charts.LineChart(seriesList, animate: false);

    if (_currentIndex == 0) {
      var monthList = [
        charts.Series<ChartModel, DateTime>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ChartModel sales, _) => sales.time ?? DateTime.now(),
          measureFn: (ChartModel sales, _) => sales.sales,
          data: Bill.getYear(type: '0'),
        )
      ];
      return charts.TimeSeriesChart(
        monthList,
        animate: true,
      );
    } else if (_currentIndex == 1) {
      var yearList = [
        charts.Series<ChartModel, DateTime>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ChartModel sales, _) => sales.time ?? DateTime.now(),
          measureFn: (ChartModel sales, _) => sales.sales,
          data: Bill.getMonth(type: '0'),
        )
      ];
      return charts.TimeSeriesChart(
        yearList,
        animate: true,
      );
    } else if (_currentIndex == 2) {
      var dayList = [
        charts.Series<ChartModel, DateTime>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ChartModel sales, _) => sales.time ?? DateTime.now(),
          measureFn: (ChartModel sales, _) => sales.sales,
          data: Bill.getDay(type: '0'),
        )
      ];
      return charts.TimeSeriesChart(
        dayList,
        animate: true,
      );
    }

    return charts.TimeSeriesChart(
      seriesList,
      animate: true,
    );
  }
}

class ChartHomePage extends StatefulWidget {
  const ChartHomePage({Key? key}) : super(key: key);

  @override
  State<ChartHomePage> createState() => _ChartHomePageState();
}

class _ChartHomePageState extends State<ChartHomePage>
    with SingleTickerProviderStateMixin {
  final List<String> _tabs = ['expense', 'income'];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: MyAppBar.build(context, _bar(), right: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  MyNav.push(context, const AnalysisPage());
                },
                child: const Label(text: 'analysis'),
              ),
            ],
          ),
        ]),
        body: const TabBarView(children: [
          ChartPage(),
          ChartPageTemp(),
        ]),
      ),
    );
  }

  TabBar _bar() {
    return TabBar(
      isScrollable: true,
      tabs: List.generate(
        _tabs.length,
        (index) => Tab(
          text: _tabs[index],
        ),
      ),
      indicatorColor: Colors.transparent,
      labelStyle: TextStyle(
          color: AppColor.black, fontSize: 16, fontWeight: FontWeight.w700),
      unselectedLabelStyle: TextStyle(
          color: AppColor.normal, fontSize: 15, fontWeight: FontWeight.w500),
    );
  }
}
