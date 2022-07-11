import 'dart:math';

import 'package:easy_keepers/helper.dart';
import 'package:easy_keepers/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key? key}) : super(key: key);

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage>
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
        appBar: MyAppBar.build(
          context,
          _bar(),
        ),
        body: TabBarView(children: [
          PieOutsideLabelChart(
            type: '1',
          ),
          PieOutsideLabelChart(
            type: '0',
          ),
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

// ignore: must_be_immutable
class PieOutsideLabelChart extends StatefulWidget {
  String type;
  PieOutsideLabelChart({Key? key, required this.type}) : super(key: key);

  @override
  State<PieOutsideLabelChart> createState() => _PieOutsideLabelChartState();
}

class _PieOutsideLabelChartState extends State<PieOutsideLabelChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _simplePie(),
        ),
      ],
    );
  }

  Widget _simplePie() {
    var seriesList = [
      charts.Series<PieSales, String>(
        id: 'Sales',
        domainFn: (PieSales sales, _) => sales.type,
        measureFn: (PieSales sales, _) => sales.sales,
        data: Bill.getClass(type: widget.type),
        labelAccessorFn: (PieSales row, _) => '111',
      )
    ];

    return charts.PieChart(
      seriesList,
      animate: true,
    );
  }
}
