// @dart=2.9
import 'dart:convert';

import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/services/firebaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                Container(height: Utils.mediaQ(context).height / 4),
                Utils.normalTextField("Code", code),
                GestureDetector(
                    onTap: () async {
                      final FirebaseDatabase db = FirebaseDatabase.instance;
                      try {
                        await db
                            .reference()
                            .child("code")
                            .child(code.text)
                            .once()
                            .then((DataSnapshot dataSnapshot) async {
                          if (dataSnapshot.value != null) {
                            //limiting
                            if (dataSnapshot.value['used'] < 10) {
                              //getting first user data
                              var odata;
                              await db
                                  .reference()
                                  .child("user")
                                  .child(dataSnapshot.value['uid'])
                                  .once()
                                  .then((DataSnapshot dataSnapshot) {
                                odata = dataSnapshot.value;
                              });
                              //updating first user data
                              FirebaseService.updateData(
                                  'user', dataSnapshot.value['uid'], {
                                'coin': odata['coin'] + custom['onRefer'],
                              });
                              //updating used of FUser
                              db
                                  .reference()
                                  .child("code")
                                  .child(code.text)
                                  .update({
                                'used': dataSnapshot.value['used'] + 1,
                              });

                              //updating this user data 100 Coin
                              FirebaseService.updateData(
                                  'user', FirebaseService.getUser(), {
                                'coin': custom['onRefRec'],
                              });

                              //Noti
                              final response = await http.post(
                                Uri.parse(
                                    'https://fcm.googleapis.com/fcm/send'),
                                headers: {
                                  'contentTypeHeader': 'application/json',
                                  'authorizationHeader': "key=$serverKey"
                                },
                                body: jsonEncode({
                                  "to": "asd",
                                  "priority": "high",
                                  "data": {
                                    "type": "100",
                                    "user_id": 'data userId',
                                    "title": 'data title',
                                    "message": 'data msg',
                                    "time":
                                        DateTime.now().millisecondsSinceEpoch,
                                    "sound": "default",
                                    "vibrate": "300",
                                  },
                                  "notification": {
                                    "vibrate": "300",
                                    "priority": "high",
                                    "body": 'noti Body',
                                    "title": 'noti title',
                                    "sound": "default"
                                  }
                                }),
                              );

                              print(response);
                            } else {
                              print("used all");
                            }
                          } else {
                            print('not found');
                          }
                        });
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Utils.flatButton(
                        "EnterDetails", MediaQuery.of(context).size.width,
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
