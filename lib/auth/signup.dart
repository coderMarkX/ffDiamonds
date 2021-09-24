// @dart=2.9
import 'package:ffdiamonds/screens/activity/enterDetails.dart';
import 'package:ffdiamonds/services/firebaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
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
    Utils.showLoadingDialog(this.context);
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: _email.text, password: _password.text))
          .user;
      if (user != null) {
        final FirebaseDatabase db = FirebaseDatabase.instance;

        FirebaseService.updateData('user', FirebaseService.getUser(), {
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
        Navigator.of(context, rootNavigator: true).pop();
        await Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => EnterDetails()),
            (route) => false);
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Utils.snackbar(
          context, e.toString().replaceRange(0, 14, '').split(']')[1],
          icon: Icons.error_outline_outlined);
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(height: Utils.mediaQ(context).height / 2),
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
                              BorderSide(color: primaryColor, width: 1.5))),
                ),
                SizedBox(height: 20),
                GestureDetector(
                    onTap: () async {
                      _register();
                    },
                    child: Utils.flatButton(
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
