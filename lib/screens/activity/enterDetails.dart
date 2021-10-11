// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EnterDetails extends StatefulWidget {
  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  final TextEditingController code = TextEditingController();
  final TextEditingController name = TextEditingController();
  static final db = FirebaseDatabase.instance;
  PageController controller = PageController();
  var currentPageValue = 0.0;
  File _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: bgColor,
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: controller,
            pageSnapping: true,
            children: [page1(), page2()],
          )),
    );
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {});
  }

  openImageDialog(BuildContext context) {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Camera",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop("Discard");
              final imageFile = await picker.pickImage(
                  source: ImageSource.camera, imageQuality: 70);
              File croppedFile = await ImageCropper.cropImage(
                  sourcePath: imageFile.path,
                  aspectRatioPresets: [CropAspectRatioPreset.square],
                  androidUiSettings: AndroidUiSettings(
                      activeControlsWidgetColor: secondaryColor,
                      toolbarTitle: 'Crop',
                      toolbarColor: primaryColor,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.square,
                      lockAspectRatio: true),
                  iosUiSettings: IOSUiSettings(
                    minimumAspectRatio: 1.0,
                  ));

              if (croppedFile != null) {
                setState(() {
                  _image = File(croppedFile.path);
                });
              }
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              "Gallery",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop("Discard");
              final imageFile = await picker.pickImage(
                  source: ImageSource.gallery, imageQuality: 70);
              File croppedFile = await ImageCropper.cropImage(
                  sourcePath: imageFile.path,
                  aspectRatioPresets: [CropAspectRatioPreset.square],
                  androidUiSettings: AndroidUiSettings(
                      activeControlsWidgetColor: secondaryColor,
                      toolbarTitle: 'Crop',
                      toolbarColor: primaryColor,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.square,
                      lockAspectRatio: true),
                  iosUiSettings: IOSUiSettings(minimumAspectRatio: 1.0));
              if (croppedFile != null) {
                setState(() {
                  _image = File(croppedFile.path);
                });
              }
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
          isDefaultAction: true,
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop("Discard");
          },
        ),
      ),
    );
  }

  Widget page1() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(height: Utils.mediaQ(context).height / 7),
            Text("Setup your profile",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'HillHouse',
                    fontWeight: FontWeight.bold,
                    fontSize: 35)),
            Container(height: Utils.mediaQ(context).height / 10),
            GestureDetector(
                onTap: () {
                  openImageDialog(context);
                },
                child: _image == null
                    ? Container(
                        height: 150,
                        width: 150,
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            radius: 75.0,
                            child: ClipOval(
                                child: CachedNetworkImage(imageUrl: dp)),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )
                    : Container(
                        height: 150,
                        width: 150,
                        child: CircleAvatar(
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            radius: 75.0,
                            child: ClipOval(
                                child: Image(image: FileImage(_image))),
                            backgroundColor: Colors.white,
                          ),
                        ),
                      )),
            SizedBox(height: 100),
            Utils.normalTextField("Your Name", name),
            SizedBox(height: 50),
            GestureDetector(
                onTap: () async {
                  name.text.isEmpty
                      ? Utils.showToast("You must enter your name",
                          color: Colors.red)
                      : controller.animateToPage(1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                },
                child: Utils.flatButton(
                    "Next", MediaQuery.of(context).size.width,
                    color: secondaryColor)),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget page2() {
    return Padding(
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
              child: GestureDetector(
                onTap: () async {
                  Utils.showLoadingDialog(this.context);
                  var imgUrl = dp;
                  if (_image != null) {
                    String fileName =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    var reference = FirebaseStorage.instance
                        .ref()
                        .child("images")
                        .child(fileName);
                    UploadTask uploadTask = reference.putFile(_image);
                    TaskSnapshot storageTaskSnapshot = await uploadTask;
                    imgUrl = await storageTaskSnapshot.ref.getDownloadURL();
                  }

                  await FBService.updateData('user', FBService.getUser().uid,
                      {'name': name.text, 'profilePic': imgUrl});
                  Navigator.of(context, rootNavigator: true).pop();
                  await Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (context) => Nav()),
                      (route) => false);
                },
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
            ),
            Container(height: Utils.mediaQ(context).height / 6),
            ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset('assets/image/code.jpg', height: 200)),
            SizedBox(height: 50),
            Utils.normalTextField("Code", code),
            SizedBox(height: 50),
            GestureDetector(
                onTap: () async {
                  try {
                    final censuredEmail = FBService.getUser().email.replaceAll(
                        new RegExp('(?<=.)[^@](?=[^@]*?[^@]@)'), '*');

                    await db
                        .reference()
                        .child("code")
                        .child(code.text)
                        .once()
                        .then((DataSnapshot dataSnapshot) async {
                      if (dataSnapshot.value != null) {
                        //limiting
                        if (dataSnapshot.value['used'] ?? 0 < 10) {
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

                          var imgUrl = dp;
                          if (_image != null) {
                            String fileName = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            var reference = FirebaseStorage.instance
                                .ref()
                                .child("images")
                                .child(fileName);
                            UploadTask uploadTask = reference.putFile(_image);
                            TaskSnapshot storageTaskSnapshot = await uploadTask;
                            imgUrl =
                                await storageTaskSnapshot.ref.getDownloadURL();
                          }

                          FBService.updateData(
                              'user', dataSnapshot.value['uid'], {
                            'name': name.text,
                            'profilePic': imgUrl,
                            'coin': odata['coin'] + custom['onRefer'],
                          });
                          //updating used of FUser
                          db.reference().child("code").child(code.text).update({
                            'used': dataSnapshot.value['used'] ?? 0 + 1,
                          });

                          //updating this user data 100 Coin
                          FBService.updateData(
                              'user', FBService.getUser().uid, {
                            'coin': custom['onRefRec'],
                          });

                          // //Noti
                          await http.post(
                            Uri.parse('https://fcm.googleapis.com/fcm/send'),
                            headers: {
                              'Content-Type': 'application/json',
                              'authorization': "key=$serverKey"
                            },
                            body: jsonEncode({
                              "to": odata['fcm'],
                              "priority": "high",
                              "notification": {
                                "vibrate": "300",
                                "priority": "high",
                                "body":
                                    'Congrats $censuredEmail used your code',
                                "title": 'Congratulation 🎉',
                                "sound": "default"
                              }
                            }),
                          );

                          FBService.updateData2(
                              'notification', odata['uid'], timestamp, {
                            'title':
                                'Congratulation 🎉 you received ${custom['onRefer']} points',
                            'body': 'Congrats $censuredEmail used your code'
                          });

                          await Navigator.pushAndRemoveUntil(
                              context,
                              CupertinoPageRoute(builder: (context) => Nav()),
                              (route) => false);
                        } else {
                          Utils.showToast("Refer code limit exceeded");
                        }
                      } else {
                        Utils.showToast("Please enter valid refer code");
                      }
                    });
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
    );
  }
}
