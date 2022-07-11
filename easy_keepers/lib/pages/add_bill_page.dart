import 'package:easy_keepers/helper.dart';
import 'package:easy_keepers/source/source.dart';
import 'package:easy_keepers/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BillAddHomePage extends StatefulWidget {
  const BillAddHomePage({Key? key}) : super(key: key);

  @override
  State<BillAddHomePage> createState() => _BillAddHomePageState();
}

class _BillAddHomePageState extends State<BillAddHomePage>
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
        body: const TabBarView(children: [
          BillAddPage(),
          BillAddPageTemp(),
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

class BillAddPage extends StatefulWidget {
  const BillAddPage({Key? key}) : super(key: key);

  @override
  State<BillAddPage> createState() => _BillAddPageState();
}

class _BillAddPageState extends State<BillAddPage> {
  List<ClassifyModel> outcome = DefultData.classifyOut;

  ClassifyModel? selectItem;
  String? _timeValue;

  final _amountController = TextEditingController();
  final _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectItem = outcome[index];
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectItem?.id == outcome[index].id
                              ? AppColor.theme
                              : AppColor.line,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          outcome[index].icon,
                          color: AppColor.normal,
                        ),
                      ),
                      Label(text: outcome[index].name),
                    ],
                  ),
                );
              },
              childCount: outcome.length, //内部控件数量
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  hintText: 'Please enter the amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                inputFormatters: AppTextInputFormatter.money,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  _showPickerDateTime();
                },
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(text: _timeValue),
                  decoration: const InputDecoration(
                    hintText: 'Please select time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextField(
                controller: _remarkController,
                decoration: const InputDecoration(
                  hintText: 'Please enter remarks',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppWidget.bottomBut(title: 'save', onTap: _save),
          ),
        ],
      ),
    );
  }

  _save() {
    if (selectItem == null) {
      AppTaost.showText('Please select classify');
      return;
    }
    if (_amountController.text.isEmpty) {
      AppTaost.showText('Please enter the amount');
      return;
    }
    if (_timeValue == null) {
      AppTaost.showText('Please select time');
      return;
    }

    Bill.save(
            amount: _amountController.text,
            type: '1',
            time: _timeValue ?? '',
            classify: selectItem?.id ?? '',
            remark: _remarkController.text)
        .then(
      (value) {
        if (value == true) {
          Navigator.pop(context, value);
        } else {
          AppTaost.showText('error...');
        }
      },
    );
  }

  _showPickerDateTime() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), // 初始化选中日期
      firstDate: DateTime(2010, 6), // 开始日期
      lastDate: DateTime.now(), // 结束日期
      initialEntryMode: DatePickerEntryMode.calendar, // 日历弹框样式
      helpText: "Please select time", // 左上方提示
      cancelText: "cancel", // 取消按钮文案
      confirmText: "confirm", // 确认按钮文案
      initialDatePickerMode: DatePickerMode.day, // 日期选择模式，默认为天数选择
    ).then((value) {
      if (value != null) {
        DateFormat df = DateFormat("yyyy-MM-dd");
        String v = df.format(value);
        setState(() {
          _timeValue = v;
        });
      }
    });
  }
}

class BillAddPageTemp extends StatefulWidget {
  const BillAddPageTemp({Key? key}) : super(key: key);

  @override
  State<BillAddPageTemp> createState() => _BillAddPageTempState();
}

class _BillAddPageTempState extends State<BillAddPageTemp> {
  List<ClassifyModel> outcome = DefultData.classifyIn;

  ClassifyModel? selectItem;
  String? _timeValue;

  final _amountController = TextEditingController();
  final _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectItem = outcome[index];
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: selectItem?.id == outcome[index].id
                              ? AppColor.theme
                              : AppColor.line,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Icon(
                          outcome[index].icon,
                          color: AppColor.normal,
                        ),
                      ),
                      Label(text: outcome[index].name),
                    ],
                  ),
                );
              },
              childCount: outcome.length, //内部控件数量
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  hintText: 'Please enter the amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
                inputFormatters: AppTextInputFormatter.money,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () {
                  _showPickerDateTime();
                },
                child: TextField(
                  enabled: false,
                  controller: TextEditingController(text: _timeValue),
                  decoration: const InputDecoration(
                    hintText: 'Please select time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: TextField(
                controller: _remarkController,
                decoration: const InputDecoration(
                  hintText: 'Please enter remarks',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: AppWidget.bottomBut(title: 'save', onTap: _save),
          ),
        ],
      ),
    );
  }

  _save() {
    if (selectItem == null) {
      AppTaost.showText('Please select classify');
      return;
    }
    if (_amountController.text.isEmpty) {
      AppTaost.showText('Please enter the amount');
      return;
    }
    if (_timeValue == null) {
      AppTaost.showText('Please select time');
      return;
    }

    Bill.save(
            amount: _amountController.text,
            type: '0',
            time: _timeValue ?? '',
            classify: selectItem?.id ?? '',
            remark: _remarkController.text)
        .then(
      (value) {
        if (value == true) {
          Navigator.pop(context, value);
        } else {
          AppTaost.showText('error...');
        }
      },
    );
  }

  _showPickerDateTime() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), // 初始化选中日期
      firstDate: DateTime(2010, 6), // 开始日期
      lastDate: DateTime.now(), // 结束日期
      initialEntryMode: DatePickerEntryMode.calendar, // 日历弹框样式
      helpText: "Please select time", // 左上方提示
      cancelText: "cancel", // 取消按钮文案
      confirmText: "confirm", // 确认按钮文案
      initialDatePickerMode: DatePickerMode.day, // 日期选择模式，默认为天数选择
    ).then((value) {
      if (value != null) {
        DateFormat df = DateFormat("yyyy-MM-dd");
        String v = df.format(value);
        setState(() {
          _timeValue = v;
        });
      }
    });
  }
}
