// @dart=2.9
import 'dart:convert';
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;

class EnterDetails extends StatefulWidget {
  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  final TextEditingController code = TextEditingController();

  PageController controller = PageController();
  var currentPageValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        body:

            //  PageView.builder(
            //   controller: controller,
            //   itemBuilder: (context, position) {
            //     if (position == currentPageValue.floor()) {
            //       return Transform(
            //         transform: Matrix4.identity()
            //           ..setEntry(3, 2, 0.004)
            //           ..rotateY(currentPageValue - position)
            //           ..rotateZ(currentPageValue - position),
            //         child: Container(
            //           color: position % 2 == 0 ? Colors.blue : Colors.pink,
            //           child: Center(
            //             child: Text(
            //               "Page",
            //               style: TextStyle(color: Colors.white, fontSize: 22.0),
            //             ),
            //           ),
            //         ),
            //       );
            //     } else if (position == currentPageValue.floor() + 1) {
            //       return Transform(
            //         transform: Matrix4.identity()
            //           ..setEntry(3, 2, 0.004)
            //           ..rotateY(currentPageValue - position)
            //           ..rotateZ(currentPageValue - position),
            //         child: Container(
            //           color: position % 2 == 0 ? Colors.blue : Colors.pink,
            //           child: Center(
            //             child: Text(
            //               "Page",
            //               style: TextStyle(color: Colors.white, fontSize: 22.0),
            //             ),
            //           ),
            //         ),
            //       );
            //     } else {
            //       return Container(
            //         color: position % 2 == 0 ? Colors.blue : Colors.pink,
            //         child: Center(
            //           child: Text(
            //             "Page",
            //             style: TextStyle(color: Colors.white, fontSize: 22.0),
            //           ),
            //         ),
            //       );
            //     }
            //   },
            //   itemCount: 10,
            // )

            Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    width: 70,
                    height: 30,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                        child: Text("SKIP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                Container(height: Utils.mediaQ(context).height / 2),
                Utils.normalTextField("Code", code),
                SizedBox(height: 50),
                GestureDetector(
                    onTap: () async {
                      final FirebaseAuth _auth = FirebaseAuth.instance;
                      try {
                        final censuredEmail = FBService.getUser()
                            .email
                            .replaceAll(
                                new RegExp('(?<=.)[^@](?=[^@]*?[^@]@)'), '*');

                        print(censuredEmail);

                        // await db
                        //     .reference()
                        //     .child("code")
                        //     .child(code.text)
                        //     .once()
                        //     .then((DataSnapshot dataSnapshot) async {
                        //   if (dataSnapshot.value != null) {
                        //     //limiting
                        //     if (dataSnapshot.value['used'] ?? 0 < 10) {
                        //       //getting first user data
                        //       var odata;
                        //       await db
                        //           .reference()
                        //           .child("user")
                        //           .child(dataSnapshot.value['uid'])
                        //           .once()
                        //           .then((DataSnapshot dataSnapshot) {
                        //         odata = dataSnapshot.value;
                        //       });
                        //       //updating first user data
                        //       FBService.updateData(
                        //           'user', dataSnapshot.value['uid'], {
                        //         'coin': odata['coin'] + custom['onRefer'],
                        //       });
                        //       //updating used of FUser
                        //       db
                        //           .reference()
                        //           .child("code")
                        //           .child(code.text)
                        //           .update({
                        //         'used': dataSnapshot.value['used'] ?? 0 + 1,
                        //       });

                        //       //updating this user data 100 Coin
                        //       FBService.updateData(
                        //           'user', FBService.getUser().uid, {
                        //         'coin': custom['onRefRec'],
                        //       });

                        //       // //Noti
                        //       await http.post(
                        //         Uri.parse(
                        //             'https://fcm.googleapis.com/fcm/send'),
                        //         headers: {
                        //           'Content-Type': 'application/json',
                        //           'authorization': "key=$serverKey"
                        //         },
                        //         body: jsonEncode({
                        //           "to":
                        //               "d7VBl41pTce5GAbFD2CN-9:APA91bFuN09mwi-iukGcbJIWQFKOyuFEIjPG7MYBlsoWy5phVoe6j1KloNLIBUXaU7kMiq6xCTQvhrRQqAK1LylXVMLo1C-ul9vCnhkig_NMUM2nID0PJaKwLirGWwUYWOP3Ws6jH49b",
                        //           "priority": "high",
                        //           "notification": {
                        //             "vibrate": "300",
                        //             "priority": "high",
                        //             "body": 'Congrats someone used your code ',
                        //             "title": 'noti title',
                        //             "sound": "default"
                        //           }
                        //         }),
                        //       );

                        // // await Navigator.pushAndRemoveUntil(
                        // //     context,
                        // //     CupertinoPageRoute(
                        // //         builder: (context) => Nav()),
                        // //     (route) => false);
                        //     } else {
                        //       print("used all");
                        //     }
                        //   } else {
                        //     print('not found');
                        //   }
                        // });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Utils.flatButton(
                        "Submit", MediaQuery.of(context).size.width,
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
