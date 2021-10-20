// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'const.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static mediaQ(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Widget flatButton(String title, double width,
      {double fSize = 16,
      double height: 50,
      color: primaryColor,
      double radius: 15,
      tColor: Colors.white}) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Center(
            child: Text(title,
                style: TextStyle(
                    color: tColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fSize))));
  }

  static Widget iosRoute(BuildContext context, Widget nav, Widget wid) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => nav));
        },
        child: wid);
  }

  static Widget normalTextField(String title, TextEditingController controller,
      {bool enabled = true,
      TextInputType type = TextInputType.text,
      int line = 1,
      cColor: primaryColor,
      tColor: Colors.white}) {
    return TextField(
        cursorColor: secondaryColor,
        style: TextStyle(color: Colors.white),
        controller: controller,
        maxLines: line,
        enabled: enabled,
        keyboardType: type,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: cColor, width: 1.5)),
            filled: true,
            fillColor: tColor.withOpacity(.3),
            labelText: title,
            labelStyle: TextStyle(color: tColor),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: cColor, width: 1.5))));
  }

  static Widget optionTile(BuildContext context, var icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        decoration: BoxDecoration(
            color: secondaryColor.withOpacity(.2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ListTile(
            title: Text(title,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            leading: Icon(icon, color: primaryColor.withOpacity(.8), size: 35)),
      ),
    );
  }

  static Widget titleWIcon(String title, IconData icon,
      {double top: 20,
      double left: 20,
      double right: 20,
      double fSize = 25,
      double iSize = 25,
      Color color = primaryColor,
      Color iColor = primaryColor}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color.withOpacity(0.2),
      ),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top, right: right, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                color: iColor ?? color,
                size: iSize,
              ),
            ),
            Text(title,
                style: TextStyle(
                    color: color,
                    fontSize: fSize,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  static Widget noData({color: primaryColor}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.bolt_slash,
              size: 180,
              color: primaryColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "No Data Found",
            style: TextStyle(
                color: primaryColor, fontSize: 30, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  static Widget noDataSmall({color: primaryColor}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.bolt_slash,
              size: 40,
              color: color,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "No Data Found",
            style: TextStyle(
                color: color, fontSize: 15, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  static Widget loading() {
    return Center(
      child: new Container(
        width: 140.0,
        height: 140.0,
        child: Column(
          children: [
            Lottie.asset('assets/animation/loading.json'),
          ],
        ),
      ),
    );
  }

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                  insetPadding: EdgeInsets.symmetric(horizontal: 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1000.0))),
                  backgroundColor: Colors.white,
                  content: Container(
                    width: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Lottie.asset('assets/animation/loading.json'),
                  )));
        });
  }

  static snackbar(context, String text,
      {icon = Icons.check_circle,
      tColor = Colors.white,
      bColor = Colors.black}) {
    final snackBar = SnackBar(

      content: Row(
        children: [
          Icon(icon, color: tColor),
          SizedBox(width: 10),
          Text(text, style: TextStyle(color: tColor)),
        ],
      ),
      backgroundColor: bColor,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static success(context,
      {bool isWid = false, Widget wid, String text = "Success", time = 2}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: time), () async {
            Navigator.pop(context);
            if (isWid) {
              Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (BuildContext context) => wid),
                  (route) => false);
            }
          });
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                  height: 300.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          height: 200,
                          child: Lottie.asset('assets/animation/success.json')),
                      Text(text,
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))
                    ],
                  )),
            ),
          );
        });
  }

  static showToast(message,
      {tColor = Colors.white, Color color = Colors.black87}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: color,
        textColor: tColor,
        fontSize: 16.0);
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    this.isBackButton = true,
    this.title,
    this.actions,
    this.goto,
    this.isGoto = false,
    Key key,
    this.tColor = Colors.black,
    this.bColor = primaryColor,
  }) : super(key: key);
  final bool isBackButton;
  final String title;
  final List<Widget> actions;
  final bool isGoto;
  final Widget goto;
  final Color tColor;
  final Color bColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 14.0),
      decoration: isBackButton
          ? null
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                !isBackButton
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          isGoto
                              ? Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => goto))
                              : Navigator.pop(context);
                        },
                        child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: bColor.withOpacity(.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Icon(Icons.keyboard_arrow_left,
                                color: bColor, size: 28)),
                      ),
                title == null
                    ? Container()
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: tColor,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          actions == null
              ? Container()
              : Row(
                  children: actions,
                ),
        ],
      ),
    );
  }
}
