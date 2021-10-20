// @dart=2.9
import 'dart:io';
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ContactUs extends StatefulWidget {
  final String title = 'test';
  @override
  State<StatefulWidget> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final name = TextEditingController();
  final msg = TextEditingController();
  final phone = TextEditingController();
  File _image;
  final picker = ImagePicker();

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
              style: TextStyle(color: Colors.black, fontSize: 16),
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
                      activeControlsWidgetColor: secondaryColor,
                      toolbarTitle: 'Crop',
                      toolbarColor: primaryColor,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.original,
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
                  aspectRatioPresets: [
                    CropAspectRatioPreset.square,
                    CropAspectRatioPreset.ratio3x2,
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.ratio4x3,
                    CropAspectRatioPreset.ratio16x9
                  ],
                  androidUiSettings: AndroidUiSettings(
                      activeControlsWidgetColor: secondaryColor,
                      toolbarTitle: 'Crop',
                      toolbarColor: primaryColor,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.original,
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(children: [
                AppBarWidget(
                    title: "Contact Us",
                    tColor: Colors.white,
                    bColor: Colors.white),
                SizedBox(height: 70),
                Utils.normalTextField("Name", name),
                SizedBox(height: 20),
                Utils.normalTextField("Phone Number", phone,
                    type: TextInputType.number),
                SizedBox(height: 20),
                Utils.normalTextField("Message", msg, line: 5),
                SizedBox(height: 30),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 8),
                        child: Text("Attachment",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)))
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
                                    border: Border.all(
                                        width: 1, color: Colors.black54),
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
                                  color: Colors.white.withOpacity(.7),
                                  size: 70,
                                )),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(
                                        width: 1, color: Colors.black54)),
                              )),
                  ],
                ),
                SizedBox(height: 50),
                GestureDetector(
                    onTap: () async {
                      if (name.text.isEmpty ||
                          phone.text.isEmpty ||
                          msg.text.isEmpty ||
                          _image == null) {
                        Utils.showToast("You must fill all details first");
                      } else {
                        Utils.showLoadingDialog(context);
                        var reference = FirebaseStorage.instance
                            .ref()
                            .child("contactus")
                            .child(timestamp);
                        UploadTask uploadTask = reference.putFile(_image);
                        TaskSnapshot storageTaskSnapshot = await uploadTask;
                        storageTaskSnapshot.ref
                            .getDownloadURL()
                            .then((downloadUrl) {
                          final databaseRef =
                              FirebaseDatabase.instance.reference();
                          databaseRef
                              .child('contactUs')
                              .child(timestamp)
                              .update({
                            'uid': FBService.getUser().uid,
                            'name': name.text,
                            'phone': phone.text,
                            'image': downloadUrl,
                            'msg': msg.text,
                            'timestanp': timestamp,
                          });
                        });
                        await Utils.success(context, isWid: true, wid: Nav());
                      }
                    },
                    child:
                        Utils.flatButton("Submit", 150, color: secondaryColor))
              ]),
            ),
          )),
    );
  }
}
