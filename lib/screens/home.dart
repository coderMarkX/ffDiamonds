// @dart=2.9
import 'package:ffdiamonds/screens/activity/form.dart';
import 'package:ffdiamonds/services/firebaseServices.dart';
// import 'package:ffdiamonds/services/firebaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  setUser() async {
    await FirebaseService.getInsideData('user', FirebaseService.getUser())
        .then((dataSnapshot) async {
      print(dataSnapshot.value);
      userData = dataSnapshot.value;
    });
  }

  @override
  void initState() {
    super.initState();
    setUser();
    print(">>" + userData.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          // Utils.iosRoute(
          //     context,
          //     RequestPage(),
          //     Utils.flatButton(
          //       "Add",
          //       200.00,
          //     )),

          // Utils.titleWIcon("Top YT", Icons.ac_unit),

          // //Featured YT
          // StreamBuilder(
          //     stream: FirebaseService.getData('featured').asStream(),
          //     builder: (context, data) {
          //       return !data.hasData
          //           ? Text("Load")
          //           : Container(
          //               height: Utils.mediaQ(context).height,
          //               child: GridView.builder(
          //                   gridDelegate:
          //                       new SliverGridDelegateWithFixedCrossAxisCount(
          //                           crossAxisCount: 7,
          //                           childAspectRatio: MediaQuery.of(context)
          //                                   .size
          //                                   .width /
          //                               (MediaQuery.of(context).size.height /
          //                                   3)),
          //                   itemCount: data.data.value.length,
          //                   itemBuilder: (BuildContext ctx, index) {
          //                     var keys = data.data.value.keys.toList();
          //                     var keyData = data.data.value[keys[index]];
          //                     return keyData['status'] == 1
          //                         ? Padding(
          //                             padding: const EdgeInsets.all(1.0),
          //                             child: GestureDetector(
          //                               onTap: () {
          //                                 showDialog(
          //                                     context: context,
          //                                     builder: (BuildContext context) {
          //                                       return AlertDialog(
          //                                         shape: RoundedRectangleBorder(
          //                                             borderRadius:
          //                                                 BorderRadius.all(
          //                                                     Radius.circular(
          //                                                         20.0))),
          //                                         content: Container(
          //                                             width: 180.0,
          //                                             height: 100.0,
          //                                             decoration: BoxDecoration(
          //                                                 color: Colors.white,
          //                                                 shape: BoxShape
          //                                                     .rectangle,
          //                                                 borderRadius:
          //                                                     BorderRadius
          //                                                         .circular(
          //                                                             20)),
          //                                             child: Column(
          //                                               mainAxisAlignment:
          //                                                   MainAxisAlignment
          //                                                       .spaceEvenly,
          //                                               children: <Widget>[
          //                                                 ElevatedButton(
          //                                                     onPressed:
          //                                                         () async {
          //                                                       try {
          //                                                         await launch(
          //                                                             keyData[
          //                                                                 'url']);
          //                                                       } catch (e) {
          //                                                         await launch(
          //                                                             "https://" +
          //                                                                 keyData[
          //                                                                     'url']);
          //                                                       }
          //                                                     },
          //                                                     child:
          //                                                         Text("open"))
          //                                               ],
          //                                             )),
          //                                       );
          //                                     });
          //                               },
          //                               child: Container(
          //                                 alignment: Alignment.center,
          //                                 child: Text(keyData['name']),
          //                                 decoration: BoxDecoration(
          //                                   color: Colors.amber,
          //                                 ),
          //                               ),
          //                             ),
          //                           )
          //                         : Container();
          //                   }),
          //             );
          //     }),

          // StreamBuilder(
          //   stream: FirebaseService.getData("youtuber").asStream(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     // return snapshot.hasData
          //     //     ?

          //     return Container(
          //       width: Utils.mediaQ(context).width,
          //       color: Colors.blue,
          //       height: 200,
          //       child: ListView.builder(
          //           scrollDirection: Axis.horizontal,
          //           itemCount: 4, //snapshot.data.value.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             // var item = snapshot.data.value[index];
          //             return Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 50),
          //               child: GestureDetector(
          //                 onTap: () {
          //                   //open URL
          //                 },
          //                 child: Column(
          //                   children: [
          //                     CircleAvatar(
          //                       radius: 70,
          //                       backgroundColor: Colors.red,
          //                     ),
          //                     Text("Name")
          //                   ],
          //                 ),
          //               ),
          //             );
          //             // Text("test");
          //             // ListTile(
          //             //     leading: Icon(Icons.list),
          //             //     trailing: Text(
          //             //       item['name'],
          //             //       style: TextStyle(
          //             //           color: Colors.green, fontSize: 15),
          //             //     ),
          //             //     title: Text(item['logo']));
          //           }),
          //     );
          //     // : Padding(
          //     //     padding: EdgeInsets.only(top: 16),
          //     //     child: Text('Awaiting result...'));
          //   },
          // ),
          //Top FEATURES

          // Utils.titleWIcon("Top Feayures", Icons.ac_unit),
          // StreamBuilder(
          //   stream: FirebaseService.getData("youtuber").asStream(),
          //   builder: (BuildContext context, AsyncSnapshot snapshot) {
          //     // return snapshot.hasData
          //     //     ?

          //     return Container(
          //       width: Utils.mediaQ(context).width,
          //       color: Colors.blue,
          //       height: 200,
          //       child: ListView.builder(
          //           scrollDirection: Axis.horizontal,
          //           itemCount: 4, //snapshot.data.value.length,
          //           itemBuilder: (BuildContext context, int index) {
          //             // var item = snapshot.data.value[index];
          //             return Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 50),
          //               child: GestureDetector(
          //                 onTap: () {
          //                   //open URL
          //                 },
          //                 child: Column(
          //                   children: [
          //                     CircleAvatar(
          //                       radius: 70,
          //                       backgroundColor: Colors.red,
          //                     ),
          //                     Text("Name")
          //                   ],
          //                 ),
          //               ),
          //             );
          //             // Text("test");
          //             // ListTile(
          //             //     leading: Icon(Icons.list),
          //             //     trailing: Text(
          //             //       item['name'],
          //             //       style: TextStyle(
          //             //           color: Colors.green, fontSize: 15),
          //             //     ),
          //             //     title: Text(item['logo']));
          //           }),
          //     );
          //     // : Padding(
          //     //     padding: EdgeInsets.only(top: 16),
          //     //     child: Text('Awaiting result...'));
          //   },
          // ),
        ],
      ))),
    );
  }
}
