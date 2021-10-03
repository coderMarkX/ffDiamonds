// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffdiamonds/screens/activity/form.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
// import 'package:ffdiamonds/services/FBServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
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
    await FBService.getInsideData('user', FBService.getUser().uid)
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


  Widget t() {
    return GridView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 3)),
      itemCount: 1,
      itemBuilder: (context, index) {
        // var item = _cats[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
              onTap: () {
                // setState(() {
                //   // _subcat = [];
                //   // // print(selectedCat);
                //   // selectedCat = item.name +
                //   //     '%' +
                //   //     item.pic +
                //   //     '@' +
                //   //     item.slug +
                //   //     '#' +
                //   //     item.id.toString();

                //   // fetchSubCat(desId(selectedCat));
                // });
              },
              child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      // color: primaryColor.withOpacity(.3),
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Center(
                      // child: Text(
                      //   item.name.toString(),
                      //   textAlign: TextAlign.center,
                      //   style:
                      //       TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      // ),
                      ))),
        );
      },
    );
  }


  getData() async {
    List featured = [];
    var a = await FBService.getData('featured');
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

  Widget _buildBody() {
    return FutureBuilder(
        future: getData(),
        builder: (context, snap) {
          return !snap.hasData
              ? Text('loading')
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 7,
                              childAspectRatio:
                                  MediaQuery.of(context).size.width /
                                      (MediaQuery.of(context).size.height / 3)),
                      itemCount: snap.data.length,
                      itemBuilder: (BuildContext ctx, index) {
                        var item = snap.data[index];

                        return Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: GestureDetector(
                            onTap: () {
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext context) {
                              //       return AlertDialog(
                              //         shape: RoundedRectangleBorder(
                              //             borderRadius:
                              //                 BorderRadius.all(
                              //                     Radius.circular(
                              //                         20.0))),
                              //         content: Container(
                              //             height: 330.0,
                              //             decoration: BoxDecoration(
                              //                 shape: BoxShape
                              //                     .rectangle,
                              //                 borderRadius:
                              //                     BorderRadius
                              //                         .circular(
                              //                             20)),
                              //             child: Column(
                              //               children: <Widget>[
                              //                 Container(
                              //                     alignment: Alignment
                              //                         .bottomRight,
                              //                     child: IconButton(
                              //                         onPressed:
                              //                             () {
                              //                           Navigator.pop(
                              //                               context);
                              //                         },
                              //                         icon: Icon(
                              //                             Icons
                              //                                 .close,
                              //                             color:
                              //                                 secondaryColor))),
                              //                 CircleAvatar(
                              //                     radius: 70,
                              //                     backgroundImage:
                              //                         CachedNetworkImageProvider(
                              //                             keyData[
                              //                                 'logo'])),
                              //                 SizedBox(height: 15),
                              //                 Text(keyData['name'],
                              //                     style: TextStyle(
                              //                         color:
                              //                             primaryColor,
                              //                         fontSize: 22,
                              //                         fontFamily:
                              //                             'JusticeLeague')),
                              //                 SizedBox(height: 20),
                              //                 GestureDetector(
                              //                   onTap: () async {
                              //                     try {
                              //                       await launch(
                              //                           keyData[
                              //                               'url']);
                              //                     } catch (e) {
                              //                       await launch(
                              //                           "https://" +
                              //                               keyData[
                              //                                   'url']);
                              //                     }
                              //                   },
                              //                   child: Utils
                              //                       .flatButton(
                              //                           "Open",
                              //                           150),
                              //                 ),
                              //               ],
                              //             )),
                              //       );
                              //     });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Image.network(item['l']),
                              decoration: BoxDecoration(color: Colors.grey),
                            ),
                          ),
                        );
                      }),
                );
        });

    // return StreamBuilder(
    //     stream: db.reference().child('d').onValue,
    //     builder: (context, snap) {
    //       var data = snap.data.snapshot.value;
    //       return !snap.hasData
    //           ? Text("Load")
    //           : Text(data[0]['name'].toString());
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyish,
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25, left: 16, right: 16, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("YT",
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RequestPage()));
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: secondaryColor.withOpacity(.5)),
                    child: Row(
                      children: [
                        Text(
                          "Add your",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                        SizedBox(width: 3),
                        Icon(Icons.arrow_forward_ios,
                            size: 12, color: primaryColor)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // //Featured YT
          // StreamBuilder(
          //     stream: FBService.getData('featured').asStream(),
          //     builder: (context, data) {
          //       return !data.hasData
          //           ? Utils.loading()
          //           : Container(
          //               height: Utils.mediaQ(context).height / 2,
          //               child: GridView.builder(
          //                   physics: BouncingScrollPhysics(),
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
          //                                             height: 330.0,
          //                                             decoration: BoxDecoration(
          //                                                 shape: BoxShape
          //                                                     .rectangle,
          //                                                 borderRadius:
          //                                                     BorderRadius
          //                                                         .circular(
          //                                                             20)),
          //                                             child: Column(
          //                                               children: <Widget>[
          //                                                 Container(
          //                                                     alignment: Alignment
          //                                                         .bottomRight,
          //                                                     child: IconButton(
          //                                                         onPressed:
          //                                                             () {
          //                                                           Navigator.pop(
          //                                                               context);
          //                                                         },
          //                                                         icon: Icon(
          //                                                             Icons
          //                                                                 .close,
          //                                                             color:
          //                                                                 secondaryColor))),
          //                                                 CircleAvatar(
          //                                                     radius: 70,
          //                                                     backgroundImage:
          //                                                         CachedNetworkImageProvider(
          //                                                             keyData[
          //                                                                 'logo'])),
          //                                                 SizedBox(height: 15),
          //                                                 Text(keyData['name'],
          //                                                     style: TextStyle(
          //                                                         color:
          //                                                             primaryColor,
          //                                                         fontSize: 22,
          //                                                         fontFamily:
          //                                                             'JusticeLeague')),
          //                                                 SizedBox(height: 20),
          //                                                 GestureDetector(
          //                                                   onTap: () async {
          //                                                     try {
          //                                                       await launch(
          //                                                           keyData[
          //                                                               'url']);
          //                                                     } catch (e) {
          //                                                       await launch(
          //                                                           "https://" +
          //                                                               keyData[
          //                                                                   'url']);
          //                                                     }
          //                                                   },
          //                                                   child: Utils
          //                                                       .flatButton(
          //                                                           "Open",
          //                                                           150),
          //                                                 ),
          //                                               ],
          //                                             )),
          //                                       );
          //                                     });
          //                               },
          //                               child: Container(
          //                                 alignment: Alignment.center,
          //                                 child: CachedNetworkImage(
          //                                     imageUrl: keyData['logo']),
          //                                 decoration:
          //                                     BoxDecoration(color: Colors.grey),
          //                               ),
          //                             ),
          //                           )
          //                         : Container();
          //                   }),
          //             );
          //     }),

          StreamBuilder(
            stream: FBService.getData("youtuber").asStream(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return !snapshot.hasData
                  ? Utils.loading()
                  : Container(
                      margin: EdgeInsets.only(left: 5),
                      width: Utils.mediaQ(context).width,
                      decoration: BoxDecoration(
                          color: secondaryColor.withOpacity(.5),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(20))),
                      height: 150,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.value.length,
                          itemBuilder: (BuildContext context, int index) {
                            var item = snapshot.data.value[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              child: GestureDetector(
                                onTap: () {
                                  //open URL
                                },
                                child: Column(
                                  children: [
                                    // CircleAvatar(
                                    //     backgroundImage:
                                    //         CachedNetworkImageProvider(item['logo']),
                                    //     radius: 40,
                                    //     backgroundColor: Colors.grey),
                                    Text(item.toString())
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
              // : Padding(
              //     padding: EdgeInsets.only(top: 16),
              //     child: Text('Awaiting result...'));
            },
          ),
        ],
      ))),
    );
  }
}
