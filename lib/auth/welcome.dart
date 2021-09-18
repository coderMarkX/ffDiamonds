import 'dart:convert';
import 'dart:io';
import 'package:ffdiamonds/auth/login.dart';
import 'package:ffdiamonds/auth/signup.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child:    Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            
                  children: [
                    Container(height: Utils.mediaQ(context).height / 1.5),
                    Utils.iosRoute(
                      context,
                      Signup(),
                      Utils.button("Signup", MediaQuery.of(context).size.width,
                          color: secondaryColor),
                    ),
                    SizedBox(height: 30),
                    Utils.iosRoute(
                      context,
                      Login(),
                      Utils.button("Login", MediaQuery.of(context).size.width,
                          color: secondaryColor),
                    )
                  ],
                ),
        ),
        

      ),
    );
  }
}
