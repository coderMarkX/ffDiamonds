// @dart=2.9
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/material.dart';

class Featured extends StatefulWidget {
  @override
  _FeaturedState createState() => _FeaturedState();
}

class _FeaturedState extends State<Featured> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        children: [
          Container(
            height: 200,
            width: Utils.mediaQ(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: primaryColor,
            ),
            child: Text("Available balance"),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            width: Utils.mediaQ(context).width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: primaryColor,
            ),
            child: Text("Earn 10 Diamond"),
          ),
        ],
      )),
    );
  }
}
