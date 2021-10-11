// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffdiamonds/game/main.dart';
import 'package:ffdiamonds/screens/activity/form.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
// import 'package:ffdiamonds/services/FBServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
// import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyish,
      body: SafeArea(
          child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: 15, left: 16, right: 16, bottom: 10),
                      child: Utils.iosRoute(
                          context,
                          MyGame(),
                          Utils.optionTile(
                              context, Icons.gamepad_outlined, "Play Game"))),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 25, left: 16, right: 16, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Youtube Channels",
                            style: TextStyle(
                                fontSize: 21, fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RequestPage()));
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: secondaryColor.withOpacity(.5)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Add",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor),
                                ),
                                SizedBox(width: 3),
                                Icon(Icons.add, size: 20, color: primaryColor)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  FutureBuilder(
                      future: getData(),
                      builder: (context, snap) {
                        return !snap.hasData
                            ? Utils.loading()
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                gridDelegate:
                                    new SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2.5)),
                                itemCount: snap.data.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  var item = snap.data[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0))),
                                                content: Container(
                                                    height: 330.0,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Container(
                                                            alignment: Alignment
                                                                .bottomRight,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                icon: Icon(
                                                                    Icons.close,
                                                                    color:
                                                                        secondaryColor))),
                                                        CircleAvatar(
                                                            radius: 70,
                                                            backgroundImage:
                                                                CachedNetworkImageProvider(
                                                                    item[
                                                                        'logo'])),
                                                        SizedBox(height: 15),
                                                        Text(item['name'],
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontSize: 22,
                                                                fontFamily:
                                                                    'JusticeLeague')),
                                                        SizedBox(height: 20),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            try {
                                                              await launch(
                                                                  item['url']);
                                                            } catch (e) {
                                                              await launch(
                                                                  "https://" +
                                                                      item[
                                                                          'url']);
                                                            }
                                                          },
                                                          child:
                                                              Utils.flatButton(
                                                                  "Subscribe",
                                                                  150),
                                                        ),
                                                      ],
                                                    )),
                                              );
                                            });
                                      },
                                      child: CachedNetworkImage(
                                          imageUrl: item['logo'],
                                          fit: BoxFit.cover),
                                    ),
                                  );
                                });
                      }),
                  Divider(height: 50),
                  Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(left: 15, bottom: 15),
                    child: Text("Top Youtubers",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var item = snapshot.data.value[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            await launch(item['url']);
                                          } catch (e) {
                                            await launch(
                                                "https://" + item['url']);
                                          }
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                                backgroundImage:
                                                    CachedNetworkImageProvider(
                                                        item['logo']),
                                                radius: 45,
                                                backgroundColor: Colors.grey),
                                            Text(item['name'],
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontSize: 15,
                                                    fontFamily:
                                                        'JusticeLeague'))
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                    },
                  ),
                ],
              ))),
    );
  }
}
