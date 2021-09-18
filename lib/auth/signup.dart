// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _obscureText = true;
  bool loader = false;
  bool isLoggedIn = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<State> keyLoader = GlobalKey<State>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> _register() async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: _email.text, password: _password.text))
          .user;
      if (user != null) {
        final FirebaseDatabase db = FirebaseDatabase.instance;
        db.reference().child("user").child(_auth.currentUser.uid).update({
          'uid': _auth.currentUser.uid,
          'email': _email.text,
          'password': _password.text,
          'coin': custom['onRegister'],
          'fcm': fcm
        });

        var refCode = _email.text.substring(0, _email.text.indexOf('@'));
        db
            .reference()
            .child("code")
            .child(refCode)
            .update({'uid': _auth.currentUser.uid, 'code': refCode});
      }
    } catch (e) {
      Utils.snackbar(context, e.message.toString());
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // @override
  // void initState() {
  //   super.initState();
  //   setFcm();
  // }

  // Future<bool> _onWillPop() {
  //   return showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text('Are you sure?'),
  //           content: Text('Do you want to exit Application ?'),
  //           actions: <Widget>[
  //             FlatButton(
  //               onPressed: () => Navigator.of(context).pop(false),
  //               child: Text('No'),
  //             ),
  //             FlatButton(
  //               onPressed: () => exit(0),
  //               child: Text('Yes'),
  //             ),
  //           ],
  //         ),
  //       ) ??
  //       false;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: Utils.mediaQ(context).height,
          child:       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Container(height: Utils.mediaQ(context).height / 1.5),
                            // Container(
                            //   child: Text(
                            //       AppLocalizations.of(context)
                            //           .translate('login'),
                            //       style: TextStyle(
                            //           color: primaryColor,
                            //           fontSize: 30,
                            //           fontWeight: FontWeight.w900)),
                            // ),
                            TextField(
                              controller: _email,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1.5),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  labelText: "Enter Email Address",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 1.5))),
                            ),
                            SizedBox(height: 20),
                            TextField(
                              controller: _password,
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      _toggle();
                                    },
                                    child: _obscureText
                                        ? Icon(
                                            Icons.visibility,
                                            color: Colors.grey,
                                          )
                                        : Icon(
                                            Icons.visibility_off,
                                            color: primaryColor,
                                          )),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: primaryColor, width: 1.5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                labelText: "Enter Password",
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: primaryColor, width: 1.5)),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                                onTap: () async {
                                  _register();
                                },
                                child: Utils.button(
                                    "Signup", MediaQuery.of(context).size.width,
                                    color: secondaryColor)),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
        ),
      ),
    );
  }
}
