// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_icons/flutter_icons.dart';

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
              AppBarWidget(title: "Top Up", tColor: primaryColor),
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

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15)),
                                            color:
                                                primaryColor.withOpacity(.4)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (coin < item['req'])
                                                Utils.snackbar(context,
                                                    "You don't have sufficient points",
                                                    bColor: Colors.red,
                                                    icon: Icons.error_outline);
                                              else
                                                showBottom(
                                                    item['req'], item['price']);
                                            },
                                            child: ListTile(
                                              leading: Container(
                                                  height: 100,
                                                  width: 70,
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
                                                            Center(
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
                                              trailing: Icon(
                                                FontAwesome.rocket,
                                                color: primaryColor,
                                                size: 30,
                                              ),
                                              title: Text(item['name'],
                                                  style: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              subtitle: Text(
                                                "*Required ${item['req']} Points",
                                                style: TextStyle(
                                                    color: primaryColor
                                                        .withOpacity(.5),
                                                    fontSize: 11),
                                              ),
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

  showBottom(req, price) {
    return showModalBottomSheet<void>(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(30.0),
              topRight: const Radius.circular(30.0))),
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Utils.normalTextField("Enter your UID", uid),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                      onTap: () async {
                        coin = coin - req;

                        Utils.showLoadingDialog(this.context);

                        FBService.updateData('user', FBService.getUser().uid, {
                          'coin': coin - req,
                        });

                        coin = coin - req;

                        await FBService.updateData2(
                            'request',
                            FBService.getUser().uid,
                            timestamp,
                            {'price': price, 'gameId': uid.text});
                        Navigator.of(context, rootNavigator: true).pop();
                        await Utils.success(context,
                            text: "Request Added", isWid: true, wid: Nav());
                      },
                      child: Utils.flatButton("Submit", 150,
                          color: secondaryColor)),
                  SizedBox(height: 20),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
