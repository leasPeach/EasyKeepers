import 'package:easy_keepers/helper.dart';
import 'package:easy_keepers/source/source.dart';
import 'package:easy_keepers/storage_manager.dart';
import 'package:flutter/material.dart';

import 'add_bill_page.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List _dataSource = [];

  double _income = 0.0;
  double _outcome = 0.0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    _dataSource = Bill.getList();
    _income = Bill.getIncome();
    _outcome = Bill.getOutcome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.build(
        context,
        'Detail',
        left: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                MyNav.push(context, const BillAddHomePage()).then((value) {
                  if (value == true) {
                    loadData();
                    setState(() {});
                  }
                });
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _totalItem(),
          // _clickItem(),
          Expanded(
            child: ListView.builder(
              itemCount: _getModelList().length,
              itemBuilder: (BuildContext context, int index) {
                var data = _getModelList()[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: AppColor.line,
                            borderRadius: BorderRadius.circular(15)),
                        child: Icon(
                          data.icon,
                          color: AppColor.theme,
                          size: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Label(
                                    text: data.remark,
                                    size: 18,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Label(
                                        text: '${data.type == '1' ?'-':'+'}${data.amount}',
                                        size: 18,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Label(
                                        text: data.time,
                                        size: 16,
                                        color: AppColor.normal,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              color: AppColor.line,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalItem() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColor.theme,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(
            10,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Label(text: 'expense'),
              Label(text: '$_outcome'),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Label(text: 'income'),
              Label(text: '$_income'),
            ],
          ),
        ],
      ),
    );
  }

  //logic
  List<BillModel> _getModelList() {
    List<BillModel> temp = [];
    for (var element in _dataSource) {
      String id = element['classify'];
      String classifyName = '';
      IconData icon = Icons.abc;
      for (var i in DefultData.classifyOut) {
        if (i.id == id) {
          icon = i.icon;
          classifyName = i.name;
        }
      }

      for (var j in DefultData.classifyIn) {
        if (j.id == id) {
          icon = j.icon;
          classifyName = j.name;
        }
      }
      BillModel model = BillModel(
          amount: element['amount'],
          classifyName: classifyName,
          icon: icon,
          remark: element['remark'],
          time: element['time'],
          type: element['type']);
      temp.add(model);
    }
    return temp;
  }
}

class BillModel {
  IconData icon;
  String amount;
  String time;
  String remark;
  String type;
  String classifyName;
  BillModel({
    required this.icon,
    required this.amount,
    required this.time,
    required this.remark,
    required this.type,
    required this.classifyName,
  });
}
