import 'package:easy_keepers/helper.dart';
import 'package:easy_keepers/pages/login_page.dart';
import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar.build(context, 'Login', showLeft: false),
    );
  }
}

class UserCenterScreen extends StatefulWidget {
  const UserCenterScreen({Key? key}) : super(key: key);

  @override
  State<UserCenterScreen> createState() => _UserCenterScreenState();
}

class _UserCenterScreenState extends State<UserCenterScreen> {
  Map detail = {};
  int noHander = 0;
  int all = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColor.theme.withAlpha(250),
                            AppColor.theme.withAlpha(50)
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 30,
                                      height: 30,
                                      child: Icon(
                                        Icons.face_retouching_natural,
                                        color: AppColor.white,
                                        size: 35,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            text: '111',
                                            size: 18,
                                            color: AppColor.white,
                                            weight: FontWeight.w500,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Label(
                                            text: '111',
                                            size: 14,
                                            color: AppColor.white,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 15,
                    right: 15,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.padding,
                              color: AppColor.theme.withAlpha(150),
                              size: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <InlineSpan>[
                                        WidgetSpan(
                                          child: Label(
                                            text: '222',
                                            color: AppColor.black,
                                            size: 16,
                                            weight: FontWeight.w500,
                                          ),
                                        ),
                                        WidgetSpan(
                                          child: Label(
                                            text: '1111',
                                            color: AppColor.blush,
                                            size: 16,
                                            weight: FontWeight.w500,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Label(
                                    text: '3333',
                                    color: AppColor.normal,
                                    size: 12,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 0,
                              color: Colors.blue.withAlpha(150),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100, bottom: 60),
              child: Column(
                children: _items(),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 60),
              child: InkWell(
                onTap: _logout,
                child: Container(
                  alignment: Alignment.center,
                  child: Label(
                    text: 'LogOut',
                    color: AppColor.white,
                    size: 17,
                  ),
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColor.theme.withAlpha(150),
                    borderRadius: BorderRadius.circular(44),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _logout() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return const LoginPage();
      },
    ), (route) => false);
  }

  List<Widget> _items() {
    List<Widget> temp = [];
    temp.addAll([
      _item(title: 'share WhatsApp', top: () {}),
      _item(title: 'save Google Drive', top: () {}),
      _item(title: 'save Baidu Netdisk', top: () {}),
    ]);

    return temp;
  }

  Widget _item({required String title, Function()? top}) {
    return InkWell(
      onTap: top,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Label(
                  text: title,
                  size: 17,
                  color: AppColor.black,
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColor.light,
                )
              ],
            ),
          ),
          Container(
            height: 1,
            color: AppColor.line,
          ),
        ],
      ),
    );
  }
}
