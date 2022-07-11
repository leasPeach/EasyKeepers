import 'package:easy_keepers/helper.dart';
import 'package:flutter/material.dart';


class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.build(context, 'Login', showLeft: false),
      
    );
  }
}
