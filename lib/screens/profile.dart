// @dart=2.9
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody for floating bar get better perfomance
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("asdsa"),
      ),
      body: Center(child: Text("Profile")),
    );
  }
}
