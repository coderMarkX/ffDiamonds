// @dart=2.9
import 'package:ffdiamonds/screens/activity/topUp.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  //AD
  String testDevice = 'YOUR_DEVICE_ID';
  int maxFailedLoadAttempts = 3;

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    _createRewardedAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) => {
        FBService.updateData('user', FBService.getUser().uid, {
          'coin': coin + custom['interAd'],
        })
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad od onAdShowedFullScreenCont.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('${ad.responseInfo} Rloaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );
    _rewardedAd.setImmersiveMode(true);
    _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      FBService.updateData('user', FBService.getUser().uid, {
        'coin': coin + custom['rewardAd'],
      });
    });
    _rewardedAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryColor,
      extendBody: true,
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.all(10.0),
                child: StreamBuilder(
                    stream: FBService.getDataStream(
                        'user', FBService.getUser().uid),
                    builder: (context, snap) {
                      var data = snap?.data?.snapshot?.value ?? [];
                      coin = !snap.hasData ? 0 : data['coin'];
                      return !snap.hasData
                          ? Utils.loading()
                          : Container(
                              height: 200,
                              width: Utils.mediaQ(context).width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: primaryColor,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Available",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        // fontFamily: 'HillHouse'
                                      )),
                                  SizedBox(height: 10),
                                  Text(data['coin'].toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        // fontFamily: 'HillHouse'
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      TopUp()));
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(right: 10),
                                          height: 50,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: secondaryColor,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("Top Up",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                              Icon(Icons.chevron_right_outlined,
                                                  color: Colors.white)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                    })),
            SizedBox(height: 5),
            Container(
              height: 500.0,
              color: secondaryColor,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                        height: 150,
                        child: Lottie.asset('assets/animation/earn.json')),
                    GestureDetector(
                      onTap: () {
                        _showInterstitialAd();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: primaryColor.withOpacity(.4)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: secondaryColor.withOpacity(.8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                      MaterialCommunityIcons.diamond_outline,
                                      size: 35,
                                      color: primaryColor),
                                ),
                              ),
                              tileColor: primaryColor,
                              trailing: Utils.flatButton("Earn", 80,
                                  height: 35, radius: 10),
                              title: Text("Earn 10",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showRewardedAd();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: primaryColor.withOpacity(.4)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: secondaryColor.withOpacity(.8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                      MaterialCommunityIcons.diamond_stone,
                                      size: 35,
                                      color: primaryColor),
                                ),
                              ),
                              tileColor: primaryColor,
                              trailing: Utils.flatButton("Earn", 80,
                                  height: 35, radius: 10),
                              title: Text("Earn 100",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // print("ok");
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(30.0),
                                  topRight: const Radius.circular(30.0))),
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: StatefulBuilder(builder:
                                  (BuildContext context, StateSetter setState) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          height: 150,
                                          child: Lottie.asset(
                                              'assets/animation/share.json')),
                                      Container(
                                        height: 100,
                                        width: Utils.mediaQ(context).width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 40.0,
                                              width:
                                                  Utils.mediaQ(context).width -
                                                      100,
                                              child: TextField(
                                                enabled: false,
                                                controller:
                                                    TextEditingController()
                                                      ..text = userData['code'],
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: primaryColor,
                                                            width: 1.5))),
                                              ),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: primaryColor),
                                                onPressed: () {
                                                  Clipboard.setData(
                                                      ClipboardData(
                                                          text: 'test'));
                                                  Utils.showToast(
                                                      "Copied Successfully");
                                                },
                                                child: Icon(Icons.copy)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      GestureDetector(
                                          onTap: () {
                                            Share.share(
                                                'check out my website https://example.com',
                                                subject: 'Look what I made!');
                                          },
                                          child:
                                              Utils.flatButton("Share", 150)),
                                      SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              }),
                            );
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: primaryColor.withOpacity(.4)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              leading: Container(
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    color: secondaryColor.withOpacity(.8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                      MaterialCommunityIcons.diamond_stone,
                                      size: 35,
                                      color: primaryColor),
                                ),
                              ),
                              tileColor: primaryColor,
                              trailing: Utils.flatButton("Refer", 80,
                                  height: 35, radius: 10),
                              title: Text("Earn 1000",
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Text("Earn 10 Diamond"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
