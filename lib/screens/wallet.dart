// @dart=2.9
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      // extendBody for floating bar get better perfomance
      extendBody: true,
      // appBar: AppBar(
      //   title: Text("asdsa"),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
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
          height: Utils.mediaQ(context).height/ 2,
          width: Utils.mediaQ(context).width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight:Radius.circular(10)),
            color: Colors.white,

          ),
          child: Column(
            children: [
              GestureDetector(
                onTap:(){
                  print("ok");
                },
                child: ListTile(
                  leading: Icon(Icons.share),
                  tileColor: primaryColor,
                  trailing: Text('icon'),
                  title: Text('share'),
                ),
              ),
           GestureDetector(
                onTap:(){
                  print("ok");
                },
                child: ListTile(
                  leading: Icon(Icons.share),
                  tileColor: primaryColor,
                  trailing: Text('icon'),
                  title: Text('share'),
                ),
              ),
                     GestureDetector(
                onTap:(){
                  print("ok");
                },
                child: ListTile(
                  leading: Icon(Icons.share),
                  tileColor: primaryColor,
                  trailing: Text('icon'),
                  title: Text('share'),
                ),
              ),
              // Text("Earn 10 Diamond"),
            ],
          ),
        ),
          ],
        ),
      ),
    );
  }
}
