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

  // static Widget hireOrFind(String title, Color color, Color btnColor,
  //     double width, double height, String src, String btnText) {
  //   return Center(
  //     child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  //         child: Container(
  //             height: height,
  //             width: width,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(20)),
  //               color: color,
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Text(
  //                   title,
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 Container(height: 120, width: 120, child: Lottie.asset(src)),
  //                 // Image.asset(
  //                 //   src,
  //                 //   height: 100,
  //                 // ),
  //                 Utils.button(btnText, 100, height: 40, color: btnColor)
  //               ],
  //             ))),
  //   );
  // }

  static Widget normalTextField(String title, TextEditingController controller,
      {bool enabled = true,
      TextInputType type = TextInputType.text,
      int line = 1}) {
    return TextField(
        cursorColor: secondaryColor,
        style: TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1.5),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(.3),
            labelText: title,
            labelStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: primaryColor, width: 1.5))));
  }

  static Widget optionTile(BuildContext context, var icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Container(
        decoration: BoxDecoration(
            color: secondaryColor.withOpacity(.2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ListTile(
            title: Text(title),
            leading: Icon(icon, color: primaryColor.withOpacity(.7)),
            trailing: Icon(Icons.arrow_forward_ios, size: 20)),
      ),
    );
  }

  static Widget leftContainer(Widget wid, {double top: 20, double left: 20}) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top),
      child: wid,
    );
  }

  static Widget simpleTitle(String title,
      {double top: 20,
      double left: 20,
      double right: 20,
      double fSize = 25,
      Color color = primaryColor}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color.withOpacity(0.1),
      ),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top, right: right, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,
            style: TextStyle(
                color: color, fontSize: fSize, fontWeight: FontWeight.bold)),
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

  // static Widget cachedImage(url, {double height = 100, double width = 100}) {
  //   return CachedNetworkImage(
  //     imageUrl: url,
  //     imageBuilder: (context, imageProvider) => Container(
  //         height: height,
  //         width: width,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: imageProvider,
  //             fit: BoxFit.cover,
  //           ),
  //         )),
  //   );
  // }

  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(1000.0))),
                  backgroundColor: Colors.white,
                  content: Container(
                    width: 120.0,
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

  static success(context, Widget wid,
      {String text = "Success", IconData icon = Icons.check_circle}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(milliseconds: 300), () async {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (BuildContext context) => wid),
                (route) => false);
          });
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                  width: 180.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(icon, color: primaryColor, size: 70),
                      Text(text,
                          style: TextStyle(color: primaryColor, fontSize: 30))
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
  }) : super(key: key);
  final bool isBackButton;
  final String title;
  final List<Widget> actions;
  final bool isGoto;
  final Widget goto;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                              color: primaryColor.withOpacity(.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: primaryColor,
                              size: 28,
                            )),
                      ),
                title == null
                    ? Container()
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
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

class LinePathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
