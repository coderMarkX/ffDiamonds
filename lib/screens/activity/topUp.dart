// @dart=2.9
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';

class TopUp extends StatefulWidget {
  @override
  _TopUpState createState() => _TopUpState();
}

class _TopUpState extends State<TopUp> {
  final TextEditingController uid = TextEditingController();

  var data = {
    'a01': {
      'name': 'name',
      'req': '10000',
      'win': '500',
      'logo':
          'https://images.fastcompany.net/image/upload/w_1280,f_auto,q_auto,fl_lossy/w_596,c_limit,q_auto:best,f_auto/fc/3034007-inline-i-applelogo.jpg'
    },
    'a02': {
      'name': 'name1',
      'req': '20000',
      'win': '1000',
      'logo':
          'https://www.tailorbrands.com/wp-content/uploads/2020/07/mcdonalds-logo.jpg'
    },
    'a03': {
      'name': 'name2',
      'req': '30000',
      'win': '1500',
      'logo':
          'https://www.tailorbrands.com/wp-content/uploads/2020/07/mcdonalds-logo.jpg'
    }
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: SingleChildScrollView(
          // physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              // Container(
              //     height: 150,
              //     child: Lottie.asset('assets/animation/earn.json')),

              AppBarWidget(),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: Utils.mediaQ(context).height,
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      // scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var keys = data.keys.toList();
                        var keyData = data[keys[index]];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (coin < int.parse(keyData['req'])) {
                                Utils.snackbar(context, "No",
                                    tColor: Colors.red);
                              } else {
                                showModalBottomSheet<void>(
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.only(
                                          topLeft: const Radius.circular(30.0),
                                          topRight:
                                              const Radius.circular(30.0))),
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
                                              // Container(
                                              //     height: 150,
                                              //     child: Lottie.asset(
                                              //         'assets/animation/share.json')),

                                              Utils.normalTextField("UID", uid,
                                                  cColor: primaryColor),

                                              SizedBox(height: 30),
                                              GestureDetector(
                                                  onTap: () async {
                                                    coin = coin -
                                                        int.parse(
                                                            keyData['req']);

                                                    await FBService.updateData(
                                                        'user',
                                                        FBService.getUser().uid,
                                                        {'coin': coin});

                                                    //inREQ
                                                    // await FBService.updateData2(
                                                    //     'topUp',
                                                    //     FBService.currUser.uid,
                                                    //     DateTime.now().mill, {
                                                    //   'gid': uid.text,
                                                    //   'price': keyData['price'],
                                                    //   'timestamp':
                                                    //       FBService.serverTime
                                                    // });
                                                  },
                                                  child: Utils.flatButton(
                                                      "Submit", 150)),
                                              SizedBox(height: 20),
                                            ],
                                          ),
                                        );
                                      }),
                                    );
                                  },
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  color: primaryColor.withOpacity(.4)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color:
                                              secondaryColor.withOpacity(.8)),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: CachedNetworkImage(
                                              imageUrl: keyData['logo'],
                                              fit: BoxFit.cover))),
                                  tileColor: primaryColor,
                                  trailing: Utils.flatButton("Claim", 80,
                                      height: 35, radius: 10),
                                  title: Text(keyData['name'],
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text(keyData['req']),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
