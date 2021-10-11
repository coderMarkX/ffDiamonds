// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TopUp extends StatefulWidget {
  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  final TextEditingController uid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              AppBarWidget(),
              FutureBuilder(
                  future: FBService.getData('topUp'),
                  builder: (context, snap) {
                    return !snap.hasData
                        ? Utils.loading()
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: Utils.mediaQ(context).height,
                              child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: snap.data.value.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var item = snap.data.value[index];
                                    print(item);
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(15)),
                                              color:
                                                  primaryColor.withOpacity(.4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              leading: Container(
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      color: secondaryColor
                                                          .withOpacity(.8)),
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      child: CachedNetworkImage(
                                                        imageUrl: item['logo'],
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  15),
                                                          child: Text(
                                                            item['price']
                                                                .toString(),
                                                            style: TextStyle(
                                                                color:
                                                                    primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 25),
                                                          ),
                                                        ),
                                                      ))),
                                              trailing: flatButton("Claim", 80,
                                                  height: 35, radius: 10),
                                              title: Text(item['name'],
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              subtitle:
                                                  Text(item['req'].toString()),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          );
                  })
            ],
          ),
        ),
      ),
    );
  }

  static Widget flatButton(String title, double width,
      {double fSize = 16,
      double height: 50,
      color: primaryColor,
      double radius: 15,
      tColor: Colors.white}) {
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(radius))),
        child: Center(
            child: Text(title,
                style: TextStyle(
                    color: tColor,
                    fontWeight: FontWeight.bold,
                    fontSize: fSize))));
  }
}
