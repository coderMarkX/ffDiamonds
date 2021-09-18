// @dart=2.9
import 'dart:io';
import 'package:ffdiamonds/services/firebaseServices.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RequestPage extends StatefulWidget {
  final String title = 'test';
  @override
  State<StatefulWidget> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  final name = TextEditingController();
  final url = TextEditingController();
  final phone = TextEditingController();
  File _image;
  final picker = ImagePicker();

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {});
  }

  openDeleteDialog(BuildContext context) {
    containerForSheet<String>(
      context: context,
      child: CupertinoActionSheet(
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: Text(
              "Camera",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "MontserratBold"),
            ),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop("Discard");
              final imageFile = await picker.pickImage(
                  source: ImageSource.camera, imageQuality: 70);
              File croppedFile = await ImageCropper.cropImage(
                  sourcePath: imageFile.path,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
                  androidUiSettings: AndroidUiSettings(
                      toolbarTitle: 'Cropper',
                      toolbarColor: primaryColor,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.original,
                      lockAspectRatio: false),
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
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: "MontserratBold"),
            ),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop("Discard");
              final imageFile = await picker.pickImage(
                  source: ImageSource.gallery, imageQuality: 70);
              File croppedFile = await ImageCropper.cropImage(
                  sourcePath: imageFile.path,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
                  androidUiSettings: AndroidUiSettings(
                      toolbarTitle: 'Cropper',
                      toolbarColor: primaryColor,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.original,
                      lockAspectRatio: false),
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

  // fetch() async {
  //   return await FBservice.getDataFirst('d');
  // }

  // fetchReq() async {
  //   print(await FBservice.getDataFirst('req'));
  //   return await FBservice.getDataFirst('req');
  // }

  // Widget flatCard(context, double width, String title, {double fSize = 16}) {
  //   return Container(
  //       height: 50,
  //       width: width,
  //       decoration: BoxDecoration(
  //           color: Colors.blue,
  //           borderRadius: BorderRadius.all(Radius.circular(15))),
  //       child: Center(
  //           child: Padding(
  //               padding: EdgeInsets.symmetric(horizontal: 24),
  //               child: Text(title,
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: fSize)))));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: [
          TextField(
            controller: name,
            decoration: new InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.teal)),
                hintText: "name",
                labelText: "name"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: url,
            keyboardType: TextInputType.multiline,
            maxLines: 5,
            decoration: new InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.teal)),
              labelText: "Url",
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                child: Text("Attachment",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    openDeleteDialog(context);
                  },
                  child: _image != null
                      ? Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: Colors.black54),
                              image: DecorationImage(
                                image: FileImage(_image),
                                fit: BoxFit.contain,
                              )))
                      : Container(
                          height: 120,
                          width: 120,
                          child: Center(
                              child: Icon(
                            Icons.photo,
                            color: primaryColor.withOpacity(.7),
                            size: 70,
                          )),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border:
                                  Border.all(width: 1, color: Colors.black54)),
                        )),
            ],
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: () async {
              // Common.showLoadingDialog(this.context, _keyLoader);
              var timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
              String fileName =
                  DateTime.now().millisecondsSinceEpoch.toString();
              var reference = FirebaseStorage.instance
                  .ref()
                  .child("images")
                  .child(fileName);
              UploadTask uploadTask = reference.putFile(_image);
              TaskSnapshot storageTaskSnapshot = await uploadTask;
              storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
                final databaseRef = FirebaseDatabase.instance.reference();
                databaseRef.child('featured').child(timeStamp).update({
                  'name': name.text,
                  'url': url.text,
                  'logo': downloadUrl,
                  'timestanp': timeStamp,
                  'status': 0
                });
              });

              // Navigator.of(_keyLoader.currentContext, rootNavigator: true)
              //     .pop();

              await showDialog(
                  barrierDismissible: false,
                  context: this.context,
                  builder: (_) {
                    return AlertDialog(
                      title: Text(
                        "Suucess",
                      ),
                      content: Text("OK"),
                      actions: [
                        TextButton(
                            child: Text("Ok"),
                            onPressed: () {
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                              // Navigator.pushReplacement(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => TabbarScreen()),
                              // );
                            })
                      ],
                    );
                  });
            },
            child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: primaryColor,
                ),
                child: Center(
                    child: Text("Subbmit",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600)))),
          )
        ]));

    //FIXME container design Circle

    // Container(
    //   margin: EdgeInsets.all(10),
    //   decoration: BoxDecoration(
    //       color: Colors.red.withOpacity(.3),
    //       borderRadius: BorderRadius.all(Radius.circular(20))),
    //   height: 120,
    //   width: MediaQuery.of(context).size.width,
    //   child:

    //   FutureBuilder(
    //       future: fetch(),
    //       builder: (context, data) {
    //         return ListView.builder(
    //           scrollDirection: Axis.horizontal,
    //           itemCount: data.data.length,
    //           shrinkWrap: true,
    //           itemBuilder: (context, index) {
    //             var item = data.data[index];
    //             return Container(
    //               margin: EdgeInsets.all(10),
    //               child: GestureDetector(
    //                 onTap: () {
    //                   showDialog(
    //                       context: context,
    //                       builder: (BuildContext context) {
    //                         return AlertDialog(
    //                           shape: RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.all(
    //                                   Radius.circular(20.0))),
    //                           content: Container(
    //                               width: 180.0,
    //                               height: 100.0,
    //                               decoration: BoxDecoration(
    //                                   color: Colors.white,
    //                                   shape: BoxShape.rectangle,
    //                                   borderRadius:
    //                                       BorderRadius.circular(20)),
    //                               child: Column(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceEvenly,
    //                                 children: <Widget>[
    //                                   ElevatedButton(
    //                                       onPressed: () {
    //                                         print(item['url']);
    //                                       },
    //                                       child: Text("open"))
    //                                 ],
    //                               )),
    //                         );
    //                       });
    //                 },
    //                 child: Column(
    //                   children: [
    //                     CircleAvatar(
    //                       radius: 30.0,
    //                       backgroundImage: NetworkImage("${item['l']}"),
    //                       backgroundColor: Colors.transparent,
    //                     ),
    //                     SizedBox(height: 10),
    //                     Text("${item['name']}")
    //                   ],
    //                 ),
    //               ),
    //             );
    //           },
    //         );
    //       }),
    // )
    // ],
    // ));
  }
}
