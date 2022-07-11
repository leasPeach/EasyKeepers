import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyAppBar {
  static build(BuildContext context, dynamic title,
      {VoidCallback? onPressed,
      Widget? left,
      List<Widget>? right,
      Color? bgColor,
      PreferredSizeWidget? bottom,
      bool showLeft = true,
      Color? leadColor}) {
    return AppBar(
      title: _createTitle(title),
      centerTitle: true,
      leading: left ??
          (showLeft == true
              ? _leading(context, onPressed, leadColor)
              : Container()),
      backgroundColor: bgColor ?? AppColor.theme,
      elevation: 0,
      actions: right,
      bottom: bottom,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  static _createTitle(dynamic title) {
    if (title is String) {
      return Text(
        title,
        style: TextStyle(
          color: AppColor.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (title is Widget) {
      return title;
    }
    return null;
  }

  /*
   * 设置左侧按钮
   */
  static _leading(BuildContext context, VoidCallback? onPressed, color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: 44,
          height: 44,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.chevron_left,
              size: 32,
              color: AppColor.white,
            ),
            onPressed: () {
              onPressed == null ? _popThis(context) : onPressed();
            },
          ),
        ),
      ],
    );
  }

  static _popThis(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    } else {
      throw 'navigator index <= 0';
    }
  }
}

class Label extends StatelessWidget {
  final String text;
  final int? lines;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final TextAlign? align;
  const Label(
      {Key? key,
      required this.text,
      this.lines,
      this.color,
      this.size,
      this.weight,
      this.align})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: lines,
      overflow: lines == null ? null : TextOverflow.ellipsis,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class AppWidget {
  static bottomBut(
      {required String title, void Function()? onTap, Color? bgColor}) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 44,
          decoration: BoxDecoration(
            color: bgColor ?? AppColor.theme,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Label(
            text: title,
            color: AppColor.black,
            size: 17,
          ),
        ),
      ),
    );
  }
}

class AppColor {
  static Color get theme => const Color.fromRGBO(248, 218, 107, 1);
  static Color get white => Colors.white;
  static Color get black => const Color(0xFF212121);
  static Color get normal => const Color(0xFF777777);
  static Color get light => const Color(0xFFA5A5A5);
  static Color get blush => const Color(0xFFFD6E62);
  static Color get line => const Color(0xFFE2E4EA);
  static Color get bgColor => const Color(0xFFF4F5F9);
}

class AppTaost {
  static loading() {
    BotToast.showCustomLoading(
      toastBuilder: (context) => loadingAnimation(),
      allowClick: true,
      clickClose: true,
      crossPage: false,
    );
  }

  static loadingUnClick() {
    BotToast.showCustomLoading(
      toastBuilder: (context) {
        return loadingAnimation();
      },
      allowClick: false,
      clickClose: false,
      crossPage: false,
    );
  }

  static closeLoading() {
    BotToast.closeAllLoading();
  }

  static showText(text) {
    BotToast.showText(text: text, align: Alignment.center);
  }

  static Widget loadingAnimation() {
    return SizedBox(
      height: 88,
      width: 88,
      child: CircularProgressIndicator(
        strokeWidth: 8,
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.theme),
      ),
    );
  }
}

class AppTextInputFormatter {
  //小数点后两位金额
  static List<TextInputFormatter> get money => [
        FilteringTextInputFormatter.allow(RegExp("[0-9.]")),
        LengthLimitingTextInputFormatter(19),
        MoneyTextInputFormatter()
      ];
}

//需要配合以下限制
// WhitelistingTextInputFormatter(RegExp("[0-9.]")),
// LengthLimitingTextInputFormatter(9),
class MoneyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newvalueText = newValue.text;

    if (newvalueText == ".") {
      //第一个数为.
      newvalueText = "0.";
    } else if (newvalueText.contains(".")) {
      if (newvalueText.lastIndexOf(".") != newvalueText.indexOf(".")) {
        //输入了2个小数点
        newvalueText = newvalueText.substring(0, newvalueText.lastIndexOf('.'));
      } else if (newvalueText.length - 1 - newvalueText.indexOf(".") > 2) {
        //输入了1个小数点 小数点后两位
        newvalueText = newvalueText.substring(0, newvalueText.indexOf(".") + 3);
      }
    }

    return TextEditingValue(
      text: newvalueText,
      selection: TextSelection.collapsed(offset: newvalueText.length),
    );
  }
}

class MyNav {
  static Future<T?> push<T extends Object?>(BuildContext context, Widget page) {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
