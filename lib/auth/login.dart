import 'dart:convert';
import 'dart:io';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;
  bool loader = false;
  bool isLoggedIn = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<State> _keyLoaderLogin = GlobalKey<State>();
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final user = TextEditingController();
  final pass = TextEditingController();
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.text, password: _password.text);
    } catch (e) {
      Utils.snackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
             backgroundColor:bgColor,
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
 
        child:         Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                                    Container(height: Utils.mediaQ(context).height / 1.5),
                 
                              TextField(
                                controller: user,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: primaryColor, width: 1.5),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    labelText: "Enter Username",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: primaryColor, width: 1.5))),
                              ),
                              SizedBox(height: 20),
                              TextField(
                                controller: pass,
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
                                    _login();
                                  },
                                  child: Utils.button(
                                      "Login", MediaQuery.of(context).size.width,
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
