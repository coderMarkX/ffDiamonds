// @dart=2.9
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
  final GlobalKey<State> keyLoader = GlobalKey<State>();

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _login() async {
    Utils.showLoadingDialog(this.context);
    try {
      await _auth
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text)
          .then((value) async => {
                Navigator.of(context, rootNavigator: true).pop(),
                await Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => Nav()),
                    (route) => false),
              });
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Utils.showToast(e.toString().replaceRange(0, 14, '').split(']')[1]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 50),
                ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/image/login.jpg', height: 200)),
                SizedBox(height: 50),
                Text("Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'HillHouse',
                        fontWeight: FontWeight.bold,
                        fontSize: 35)),
                Container(height: Utils.mediaQ(context).height / 10),
                Utils.normalTextField("Email Address", _email),
                SizedBox(height: 20),
                TextField(
                    cursorColor: secondaryColor,
                    style: TextStyle(color: Colors.white),
                    controller: _password,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            onTap: () {
                              _toggle();
                            },
                            child: _obscureText
                                ? Icon(Icons.visibility, color: Colors.grey)
                                : Icon(Icons.visibility_off,
                                    color: secondaryColor)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 1.5)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(.3),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 1.5)))),
                SizedBox(height: 20),
                GestureDetector(
                    onTap: () async {
                      _login();
                    },
                    child: Utils.flatButton(
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
