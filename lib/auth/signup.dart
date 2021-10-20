// @dart=2.9
import 'package:device_info/device_info.dart';
import 'package:ffdiamonds/screens/activity/enterDetails.dart';
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
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
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  Future<void> _register() async {
    Utils.showLoadingDialog(this.context);
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    DataSnapshot deviceD = await FBService.getData('deviceId');
    List devices = deviceD?.value?.keys?.toList() ?? [];
    try {
      User user = (await _auth.createUserWithEmailAndPassword(
              email: _email.text, password: _password.text))
          .user;
      if (user != null) {
        final FirebaseDatabase db = FirebaseDatabase.instance;

        var refCode =
            _auth.currentUser.uid.substring(_auth.currentUser.uid.length - 5);
        FBService.updateData('user', FBService.getUser().uid, {
          'uid': _auth.currentUser.uid,
          'email': _email.text,
          'name':_email.text.substring(0, 7),
          'profilePic':dp,
          'password': _password.text,
          'coin': custom['onRegister'],
          'fcm': fcm,
          'code': refCode
        });
        await FBService.updateData(
            'deviceId', androidInfo.androidId, {'uid': _auth.currentUser.uid});
        db
            .reference()
            .child("code")
            .child(refCode)
            .update({'uid': _auth.currentUser.uid, 'code': refCode});
        Navigator.of(context, rootNavigator: true).pop();
        if (devices.contains(androidInfo.androidId)) {
          Utils.showToast("This device is already registered",
              color: Colors.red);
          await Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => Nav()),
              (route) => false);
        } else {
          await Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) => EnterDetails()),
              (route) => false);
        }
      }
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      Utils.showToast(e.toString().replaceRange(0, 14, '').split(']')[1]);
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

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
                SizedBox(height: 50),
                ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset('assets/image/signup.jpg', height: 200)),
                SizedBox(height: 50),
                Text("Signup",
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
