// @dart=2.9
import 'package:ffdiamonds/auth/welcome.dart';
import 'package:ffdiamonds/screens/activity/conatctUs.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // SizedBox(height: size.height / 15),
              ClipPath(
                clipper: LinePathClass(),
                child: Container(
                    width: Utils.mediaQ(context).width,
                    height: 280,
                    decoration: BoxDecoration(color: primaryColor),
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //   image: ExactAssetImage('assets/images/profileBg.jpg'),
                    //   fit: BoxFit.cover,
                    // )),
                    child:

                        //  userData.length < 1
                        //     ? Utils.loading()
                        //     :

                        Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 15.0, top: 5),
                              child: Align(
                                alignment: FractionalOffset.bottomRight,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // setState(() {
                                        //   haveNew = false;
                                        // });
                                        // Navigator.push(
                                        //     context,
                                        //     CupertinoPageRoute(
                                        //         builder: (context) =>
                                        //             NotificationList()

                                        //             ));
                                      },
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        child: Center(
                                          child: Icon(
                                              Icons.notifications_none_outlined,
                                              color: primaryColor,
                                              size: 25),
                                        ),
                                      ),
                                    ),
                                    // Visibility(
                                    //   visible: haveNew,
                                    //   child: Positioned(
                                    //       right: 1,
                                    //       top: 1,
                                    //       child: Container(
                                    //           decoration: BoxDecoration(
                                    //               borderRadius:
                                    //                   BorderRadius
                                    //                       .circular(10.0),
                                    //               color: Colors.red[400]),
                                    //           constraints: BoxConstraints(
                                    //               minWidth: 9,
                                    //               minHeight: 9))),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     CupertinoPageRoute(
                                //         builder: (context) =>
                                //             EditSeekerProfile(
                                //                 data: userData)));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 5, right: 15),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: Icon(Icons.edit_outlined,
                                    color: primaryColor, size: 25),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor: primaryColor,
                            child: CircleAvatar(
                              radius: 90.0,
                              child: ClipOval(
                                  // child: Utils.cachedImage(
                                  //     profile_store +
                                  //             userData['image'] ??
                                  //         "")

                                  ),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Column(
                          children: [
                            // Text(
                            //     "${userData['name'][0].toUpperCase() + userData['name'].substring(1)}" ??
                            //         "",
                            //     style: TextStyle(
                            //       color: whiteColor.withOpacity(.9),
                            //       fontSize: 25.0,
                            //       fontWeight: FontWeight.w800,
                            //     )),
                            SizedBox(height: 10),
                            // Text(
                            //     userData['tagline'] != null
                            //         ? "${userData['tagline'].toUpperCase()}"
                            //         : "",
                            //     style: TextStyle(
                            //       color: whiteColor,
                            //       fontSize: 12.0,
                            //     )),
                            SizedBox(height: 10),
                      
                          ],
                        ),
                      ],
                    )),
              ),

              //Options
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  children: [
                    Utils.iosRoute(
                        context,
                        ContactUs(),
                        Utils.optionTile(context,
                            Icons.contact_support_outlined, "Contact Us")),

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
          
          return (!snap.hasData && snap.data.length > 0) ? Container() : Container(
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
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
                          (BuildContext context, StateSetter setState) {
                        return ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                Container(
                                    height: 100,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(item['l']))),
                                SizedBox(width: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(item['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20)),
                                    SizedBox(height: 10),
                                    Container(
                                        alignment: Alignment.bottomRight,
                                        child: Utils.flatButton("Download", 100,
                                            color: Colors.green[800],
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
                                      (BuildContext context, int index2) {
                                    var ss = allSS[index2];
                                    return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Image.network(ss)));
                                  }),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 5, top: 5),
                                alignment: Alignment.topLeft,
                                child: Text('Description',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500))),
                            Container(
                                padding: EdgeInsets.only(left: 5, top: 10),
                                alignment: Alignment.topLeft,
                                child: Text(item['desc'],
                                    style: TextStyle(
                                        color: Colors.grey[700],
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400)))
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
                            fontWeight: FontWeight.w600, fontSize: 20))
                  ],
                )),
          );
        },
      ),
    );
        }
    );
        
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
