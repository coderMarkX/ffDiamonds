// @dart=2.9
import 'dart:io';

import 'package:ffdiamonds/screens/home.dart';
import 'package:ffdiamonds/screens/profile.dart';
import 'package:ffdiamonds/screens/wallet.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  List<Widget> pages = <Widget>[Home(), Wallet(), Profile()];
  int _index = 0;
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
}
