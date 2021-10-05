// @dart=2.9
import 'dart:io';
import 'package:ffdiamonds/auth/login.dart';
import 'package:ffdiamonds/auth/signup.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                                padding:
                                    EdgeInsets.only(right: 10.0, left: 10.0),
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

    return WillPopScope(
      onWillPop: _onExit,
      child: Scaffold(
        backgroundColor: bgColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(height: Utils.mediaQ(context).height / 6),
                Image.asset('assets/image/logo.png', height: 250),
                Container(height: Utils.mediaQ(context).height / 6),
                Utils.iosRoute(
                  context,
                  Login(),
                  Utils.flatButton("Login", MediaQuery.of(context).size.width,
                      color: secondaryColor),
                ),
                SizedBox(height: 30),
                Utils.iosRoute(
                  context,
                  Signup(),
                  Utils.flatButton("Signup", MediaQuery.of(context).size.width,
                      color: secondaryColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
