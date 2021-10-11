// @dart=2.9
import 'dart:io';
import 'package:ffdiamonds/screens/home.dart';
import 'package:ffdiamonds/screens/profile.dart';
import 'package:ffdiamonds/screens/wallet.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  List<Widget> pages = <Widget>[Home(), Wallet(), Profile()];
  int _index = 0;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: '1.0.0',
    buildNumber: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<bool> _onExit() {
    return showDialog(
            context: context,
            builder: (context) => Dialog(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Wrap(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                "Are you sure you want to exit ?",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Padding(
                              padding: EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width:
                                          (Utils.mediaQ(context).width / 3.5),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Text(
                                        "No",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      exit(0);
                                      // SharedPreferences prefs =
                                      //     await SharedPreferences.getInstance();
                                      // prefs.setString('id', null);
                                      // prefs.setString('type', null);
                                      // prefs.setString('comId', null);
                                      // userData.clear();
                                      // Navigator.pushAndRemoveUntil(
                                      //     context,
                                      //     CupertinoPageRoute(
                                      //         builder: (context) =>
                                      //             EnterMobile() //LoginEmail(),
                                      //         ),
                                      //     (Route<dynamic> route) => false);
                                    },
                                    child: Container(
                                      width:
                                          (Utils.mediaQ(context).width / 3.5),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    // if (custom != null &&
    //     int.parse(custom['isUpdate'].replaceAll(".", "")) >
    //         int.parse(_packageInfo.version.replaceAll(".", "")))
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     await updatePopup(context);
    //   });

    return WillPopScope(
      onWillPop: _onExit,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: IndexedStack(index: _index, children: pages),
          bottomNavigationBar: FloatingNavbar(
            itemBorderRadius: 15,
            borderRadius: 15,
            unselectedItemColor: Colors.white.withOpacity(.7),
            selectedBackgroundColor: secondaryColor,
            backgroundColor: primaryColor,
            selectedItemColor: Colors.white,
            onTap: (int val) => setState(() => _index = val),
            currentIndex: _index,
            items: [
              FloatingNavbarItem(icon: Icons.home, title: 'Home'),
              FloatingNavbarItem(icon: Icons.wallet_giftcard, title: 'Wallet'),
              FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  updatePopup(context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0))),
              backgroundColor: Colors.white,
              content: Container(
                  width: 220.0,
                  height: 300.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("asdasddas sdfsdfdf ?",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700)),
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("update",
                            style: TextStyle(
                                fontSize: 17, color: Colors.grey[800])),
                      ),
                      SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text("""
asdasdfjasbfhasbfhb
asdasdasf
sdgagsdfgadhadhdh
"""),
                      ),
                      SizedBox(height: 20),
                      Container(
                          alignment: Alignment.bottomRight,
                          child: Utils.flatButton("Update", 80,
                              color: Colors.green[800], radius: 5, height: 35)),
                      SizedBox(height: 10),
                      Divider(thickness: 1.5),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                              width: 150,
                              child: Image.asset('assets/image/play.png')),
                        ],
                      )
                    ],
                  )),
            ),
          );
        });
  }
}
