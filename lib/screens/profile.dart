// @dart=2.9
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffdiamonds/auth/welcome.dart';
import 'package:ffdiamonds/screens/activity/conatctUs.dart';
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController name = TextEditingController();
  File _image;
  final picker = ImagePicker();

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

  Future<bool> sure() {
    return showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Wrap(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            "Are you sure you want to Logout ?",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.0, left: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: (Utils.mediaQ(context).width / 3.5),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await FBService.logout();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => Welcome()),
                                      (route) => false);
                                },
                                child: Container(
                                  width: (Utils.mediaQ(context).width / 3.5),
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
                width: Utils.mediaQ(context).width,
                height: 250,
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(.3),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: FractionalOffset.topRight,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(30.0),
                                    topRight: const Radius.circular(30.0))),
                            context: context,
                            builder: (BuildContext context) {
                              return SingleChildScrollView(
                                child: StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(height: 50),
                                        GestureDetector(
                                            onTap: () {
                                              openImageDialog(context);
                                            },
                                            child: _image == null
                                                ? Container(
                                                    height: 120,
                                                    width: 120,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          primaryColor,
                                                      child: CircleAvatar(
                                                        radius: 75.0,
                                                        child: ClipOval(
                                                            child: CachedNetworkImage(
                                                                imageUrl: userData[
                                                                    'profilePic'])),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 120,
                                                    width: 120,
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          primaryColor,
                                                      child: CircleAvatar(
                                                        radius: 75.0,
                                                        child: ClipOval(
                                                            child: Image(
                                                                image: FileImage(
                                                                    _image))),
                                                        backgroundColor:
                                                            Colors.white,
                                                      ),
                                                    ),
                                                  )),
                                        SizedBox(height: 100),
                                        Utils.normalTextField("Name", name),
                                        SizedBox(height: 50),
                                        GestureDetector(
                                            onTap: () async {
                                              Utils.showLoadingDialog(
                                                  this.context);
                                              var imgUrl =
                                                  userData['profilePic'];
                                              if (_image != null) {
                                                String fileName = DateTime.now()
                                                    .millisecondsSinceEpoch
                                                    .toString();
                                                var reference = FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child("images")
                                                    .child(fileName);
                                                UploadTask uploadTask =
                                                    reference.putFile(_image);
                                                TaskSnapshot
                                                    storageTaskSnapshot =
                                                    await uploadTask;
                                                imgUrl =
                                                    await storageTaskSnapshot
                                                        .ref
                                                        .getDownloadURL();
                                              }

                                              await FBService.updateData('user',
                                                  FBService.getUser().uid, {
                                                'name': name.text,
                                                'profilePic': imgUrl
                                              });
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop();
                                              await Navigator
                                                  .pushAndRemoveUntil(
                                                      context,
                                                      CupertinoPageRoute(
                                                          builder: (context) =>
                                                              Nav()),
                                                      (route) => false);
                                            },
                                            child:
                                                Utils.flatButton("Save", 150)),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 5, right: 15),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: secondaryColor.withOpacity(.8),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child:
                              Icon(Icons.edit, color: Colors.white, size: 30),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: CircleAvatar(
                        backgroundColor: primaryColor,
                        child: CircleAvatar(
                          radius: 100.0,
                          child: ClipOval(
                              child: CachedNetworkImage(
                                  imageUrl: userData['profilePic'])),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                        // "${userData['name'][0].toUpperCase() + userData['name'].substring(1)}" ??
                            "",
                        style: TextStyle(
                            color: secondaryColor,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w800))
                  ],
                )),

            //Options
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Column(
                children: [
                  Utils.iosRoute(
                      context,
                      ContactUs(),
                      Utils.optionTile(context, Icons.contact_support_outlined,
                          "Contact Us")),
                  GestureDetector(
                      onTap: () async {
                        sure();
                      },
                      child: Utils.optionTile(
                          context, Icons.exit_to_app_rounded, "Logout")),
                ],
              ),
            ),
            myApps()
          ],
        ),
      ),
    ));
  }

  getData() async {
    List featured = [];
    var a = await FBService.getData('otherApps');
    var aa = a.value;
    var k = aa.keys.toList();
    for (var i in k) {
      if (aa[i].containsValue(1)) {
        featured.add(aa[i]);
        featured.toSet().toList();
      }
    }
    return featured;
  }

  Widget myApps() {
    return FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          return (!snap.hasData)
              ? Container()
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: GridView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 1.7)),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var item = snap.data[index];
                      List allSS = item['img'];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet<void>(
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.only(
                                        topLeft: const Radius.circular(30.0),
                                        topRight: const Radius.circular(30.0))),
                                context: context,
                                builder: (BuildContext context) {
                                  return StatefulBuilder(builder:
                                      (BuildContext context,
                                          StateSetter setState) {
                                    return ListView(
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(width: 20),
                                            SizedBox(width: 20),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(item['name'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 20)),
                                                SizedBox(height: 10),
                                                Container(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Utils.flatButton(
                                                        "Download", 100,
                                                        color:
                                                            Colors.green[800],
                                                        radius: 5,
                                                        height: 35)),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Container(
                                          height: 200,
                                          child: ListView.builder(
                                              physics: BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: allSS.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index2) {
                                                var ss = allSS[index2];
                                                return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        child:
                                                            Image.network(ss)));
                                              }),
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 5, top: 5),
                                            alignment: Alignment.topLeft,
                                            child: Text('Description',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500))),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 5, top: 10),
                                            alignment: Alignment.topLeft,
                                            child: Text(item['desc'],
                                                style: TextStyle(
                                                    color: Colors.grey[700],
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w400)))
                                      ],
                                    );
                                  });
                                },
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(item['l']))),
                                Text(item['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20))
                              ],
                            )),
                      );
                    },
                  ),
                );
        });
  }
}



// import 'package:Rentors/data/globalData.dart';
// import 'package:Rentors/fragments/settings/editProfile.dart';
// import 'package:Rentors/functions/localizations.dart';
// import 'package:Rentors/widgtes/avatarWidget.dart';
// import 'package:Rentors/widgtes/carImage.dart';
// import 'package:Rentors/widgtes/common.dart';
// import 'package:flutter/material.dart';
// import 'package:Rentors/widgtes/const.dart';
// import 'package:Rentors/fragments/homePage.dart';

// class Account extends StatefulWidget {
//   final bool isAppbar;
//   Account(this.isAppbar);

//   static const String routeName = '/Account';
//   @override
//   _AccountState createState() => _AccountState();
// }

// class _AccountState extends State<Account> {
//   Future<bool> _onWillPop() async {
//     Navigator.pushNamedAndRemoveUntil(
//         context, homePage.routeName, ModalRoute.withName("/"));
//     return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//           backgroundColor: bgGrey,
//           body: SafeArea(
//             child: SingleChildScrollView(
//               child: SingleChildScrollView(
//                 physics: BouncingScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     buildHeader(),
//                     buildBody(),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }

//   Widget buildHeader() {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: [
//           widget.isAppbar
//               ? AppBarWidget(
//                   title: AppTranslations.of(context).text("key_account"),
//                   isGoto: true,
//                   goto: homePage(),
//                 )
//               : Container(),
//           widget.isAppbar ? SizedBox(height: 20) : Container(),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: Row(
//               children: [
//                 AvatarWidget(
//                   photoURL: user["profile_pic"] ?? "",
//                   membership: "Profile",
//                   progress: 80,
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 1.7),
//                           child: Text(
//                             user["name"] ?? "",
//                             style: TextStyle(
//                               fontSize: 19,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Utils.iosRoute(
//                   this.context,
//                   EditProfile(
//                     data: {
//                       "name": user["name"],
//                       "email": user["email"],
//                       "phone": user["mobile"],
//                       "address": user["address"],
//                       "city": user["city"],
//                       "image": user["profile_pic"]
//                     },
//                   ),
//                   Container(
//                     width: 45,
//                     height: 45,
//                     decoration: BoxDecoration(
//                       color: primaryColor,
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(15),
//                       ),
//                     ),
//                     child: Icon(
//                       Icons.edit_outlined,
//                       color: Colors.white,
//                       size: 25,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildBody() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//       margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(7)),
//       child: Column(
//         children: [
//           buildItemData(
//             icon: Icons.email_outlined,
//             name: "Email",
//             data: user["email"] ?? "-",
//           ),
//           Divider(),
//           buildItemData(
//               icon: Icons.phone_outlined,
//               name: "Phone",
//               data: user["mobile"].toString() ?? "-"),
//           Divider(),
//           buildItemData(
//             icon: Icons.home_outlined,
//             name: "Address",
//             data: user["address"] ?? "-",
//           ),
//           Divider(),
//           buildItemData(
//             icon: Icons.location_on_outlined,
//             name: "City",
//             data: user["city"] ?? "-",
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildItemData({
//     @required IconData icon,
//     @required String name,
//     @required String data,
//   }) {
//     return Row(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Icon(icon, color: primaryColor, size: 30),
//         ),
//         Expanded(
//             child: Padding(
//           padding: const EdgeInsets.all(8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 4.0),
//                 child: Text(
//                   data,
//                   style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         )),
//       ],
//     );
//   }
// }
