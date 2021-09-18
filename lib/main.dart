// // adb tcpip 5555
// // adb connect 192.168.0.100:5555
// @dart=2.9

// import 'package:ffdiamonds/auth/welcome.dart';
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/utils/const.dart';
// import 'package:ffdiamonds/utils/globadData.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
      MyApp()
    );
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final FirebaseDatabase db = FirebaseDatabase.instance;
  // var messaging = FirebaseMessaging.instance;
  // setCustom() async {
  //   await db
  //       .reference()
  //       .child("custom")
  //       .once()
  //       .then((DataSnapshot dataSnapshot) async {
  //     custom = dataSnapshot.value;
  //   });


  //   await messaging.getToken().then((value) {
  //     fcm = value;
  //   });
  // }

  // bool loggedIn = false;
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    // setCustom();
    // if (_auth.currentUser != null) {
    //   setState(() {
    //     loggedIn = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    // if (custom != null && custom['isUpdate'])
    //   WidgetsBinding.instance.addPostFrameCallback((_) async {
    //     return newUpdate(context);
    //   });

    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'JosefinSans',
            primaryColor: primaryColor,
            primarySwatch: Colors.teal),
        title: 'FFDiamonds',
        debugShowCheckedModeBanner: false,
        home: 
        // loggedIn ?
        
         Nav() 
         
        //  : Welcome()
         );
  }

  static newUpdate(context,
      {String text = "Success", IconData icon = Icons.check_circle}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                  width: 180.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(icon, color: primaryColor, size: 70),
                      Text(text,
                          style: TextStyle(color: primaryColor, fontSize: 30))
                    ],
                  )),
            ),
          );
        });
  }
}


// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// ignore_for_file: public_member_api_docs

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   MobileAds.instance.initialize();
//   runApp(MyApp());
// }

// // You can also test with your own ad unit IDs by registering your device as a
// // test device. Check the logs for your device's ID value.
// const String testDevice = 'YOUR_DEVICE_ID';
// const int maxFailedLoadAttempts = 3;

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   static final AdRequest request = AdRequest(
//     keywords: <String>['foo', 'bar'],
//     contentUrl: 'http://foo.com/bar.html',
//     nonPersonalizedAds: true,
//   );

//   InterstitialAd? _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;

//   RewardedAd? _rewardedAd;
//   int _numRewardedLoadAttempts = 0;

//   BannerAd? _anchoredBanner;
//   bool _loadingAnchoredBanner = false;

//   @override
//   void initState() {
//     super.initState();
//     _createInterstitialAd();
//     _createRewardedAd();
//   }

//   void _createInterstitialAd() {
//     InterstitialAd.load(
//         adUnitId: InterstitialAd.testAdUnitId,
//         request: request,
//         adLoadCallback: InterstitialAdLoadCallback(
//           onAdLoaded: (InterstitialAd ad) {
//             print('$ad loaded');
//             _interstitialAd = ad;
//             _numInterstitialLoadAttempts = 0;
//             _interstitialAd!.setImmersiveMode(true);
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('InterstitialAd failed to load: $error.');
//             _numInterstitialLoadAttempts += 1;
//             _interstitialAd = null;
//             if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
//               _createInterstitialAd();
//             }
//           },
//         ));
//   }

//   void _showInterstitialAd() {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createInterstitialAd();
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }

//   void _createRewardedAd() {
//     RewardedAd.load(
//         adUnitId: RewardedAd.testAdUnitId,
//         request: request,
//         rewardedAdLoadCallback: RewardedAdLoadCallback(
//           onAdLoaded: (RewardedAd ad) {
//             print('$ad loaded.');
//             _rewardedAd = ad;
//             _numRewardedLoadAttempts = 0;
//           },
//           onAdFailedToLoad: (LoadAdError error) {
//             print('RewardedAd failed to load: $error');
//             _rewardedAd = null;
//             _numRewardedLoadAttempts += 1;
//             if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
//               _createRewardedAd();
//             }
//           },
//         ));
//   }

//   void _showRewardedAd() {
//     if (_rewardedAd == null) {
//       print('Warning: attempt to show rewarded before loaded.');
//       return;
//     }
//     _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (RewardedAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (RewardedAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         _createRewardedAd();
//       },
//       onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         _createRewardedAd();
//       },
//     );

//     _rewardedAd!.setImmersiveMode(true);
//     _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
//       print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
//     });
//     _rewardedAd = null;
//   }

//   // Future<void> _createAnchoredBanner(BuildContext context) async {
//   //   final AnchoredAdaptiveBannerAdSize? size =
//   //       await AdSize.getAnchoredAdaptiveBannerAdSize(
//   //     Orientation.portrait,
//   //     MediaQuery.of(context).size.width.truncate(),
//   //   );

//   //   if (size == null) {
//   //     print('Unable to get height of anchored banner.');
//   //     return;
//   //   }

//   //   final BannerAd banner = BannerAd(
//   //     size: size,
//   //     request: request,
//   //     adUnitId: Platform.isAndroid
//   //         ? 'ca-app-pub-3940256099942544/6300978111'
//   //         : 'ca-app-pub-3940256099942544/2934735716',
//   //     listener: BannerAdListener(
//   //       onAdLoaded: (Ad ad) {
//   //         print('$BannerAd loaded.');
//   //         setState(() {
//   //           _anchoredBanner = ad as BannerAd?;
//   //         });
//   //       },
//   //       onAdFailedToLoad: (Ad ad, LoadAdError error) {
//   //         print('$BannerAd failedToLoad: $error');
//   //         ad.dispose();
//   //       },
//   //       onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//   //       onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//   //     ),
//   //   );
//   //   return banner.load();
//   // }

//   @override
//   void dispose() {
//     super.dispose();
//     _interstitialAd?.dispose();
//     _rewardedAd?.dispose();
//     _anchoredBanner?.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Builder(builder: (BuildContext context) {
//         // if (!_loadingAnchoredBanner) {
//         //   _loadingAnchoredBanner = true;
//         //   // _createAnchoredBanner(context);
//         // }
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('AdMob Plugin example app'),
//             actions: <Widget>[
//               PopupMenuButton<String>(
//                 onSelected: (String result) {
//                   switch (result) {
//                     case 'InterstitialAd':
//                       _showInterstitialAd();
//                       break;
//                     case 'RewardedAd':
//                       _showRewardedAd();
//                       break;
//                     default:
//                       throw AssertionError('unexpected button: $result');
//                   }
//                 },
//                 itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
//                   PopupMenuItem<String>(
//                     value: '$InterstitialAd',
//                     child: Text('$InterstitialAd'),
//                   ),
//                   PopupMenuItem<String>(
//                     value: '$RewardedAd',
//                     child: Text('$RewardedAd'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           body: SafeArea(
//             child: Stack(
//               alignment: AlignmentDirectional.bottomCenter,
//               children: <Widget>[
//                 // ReusableInlineExample(),

//                 ElevatedButton(
//                     onPressed: () {
//                       _showRewardedAd();
//                     },
//                     child: Text("asd"))

//                 // if (_anchoredBanner != null)
//                 //   Container(
//                 //     color: Colors.green,
//                 //     width: _anchoredBanner!.size.width.toDouble(),
//                 //     height: _anchoredBanner!.size.height.toDouble(),
//                 //     child: AdWidget(ad: _anchoredBanner!),
//                 //   ),
//               ],
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }

// /// This example demonstrates inline ads in a list view, where the ad objects
// /// live for the lifetime of this widget.
// class ReusableInlineExample extends StatefulWidget {
//   @override
//   _ReusableInlineExampleState createState() => _ReusableInlineExampleState();
// }

// class _ReusableInlineExampleState extends State<ReusableInlineExample> {
//   BannerAd? _bannerAd;
//   bool _bannerAdIsLoaded = false;

//   AdManagerBannerAd? _adManagerBannerAd;
//   bool _adManagerBannerAdIsLoaded = false;

//   NativeAd? _nativeAd;
//   bool _nativeAdIsLoaded = false;

//   @override
//   Widget build(BuildContext context) => Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: ListView.separated(
//             itemCount: 20,
//             separatorBuilder: (BuildContext context, int index) {
//               return Container(
//                 height: 40,
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               final BannerAd? bannerAd = _bannerAd;
//               if (index == 5 && _bannerAdIsLoaded && bannerAd != null) {
//                 return Container(
//                     height: bannerAd.size.height.toDouble(),
//                     width: bannerAd.size.width.toDouble(),
//                     child: AdWidget(ad: bannerAd));
//               }

//               final AdManagerBannerAd? adManagerBannerAd = _adManagerBannerAd;
//               if (index == 10 &&
//                   _adManagerBannerAdIsLoaded &&
//                   adManagerBannerAd != null) {
//                 return Container(
//                     height: adManagerBannerAd.sizes[0].height.toDouble(),
//                     width: adManagerBannerAd.sizes[0].width.toDouble(),
//                     child: AdWidget(ad: _adManagerBannerAd!));
//               }

//               final NativeAd? nativeAd = _nativeAd;
//               if (index == 15 && _nativeAdIsLoaded && nativeAd != null) {
//                 return Container(
//                     width: 250, height: 350, child: AdWidget(ad: nativeAd));
//               }

//               return Text(
//                 // Constants.placeholderText,
//                 "test",
//                 style: TextStyle(fontSize: 24),
//               );
//             },
//           ),
//         ),
//       );

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     // Create the ad objects and load ads.
//     _bannerAd = BannerAd(
//         size: AdSize.banner,
//         adUnitId: Platform.isAndroid
//             ? 'ca-app-pub-3940256099942544/6300978111'
//             : 'ca-app-pub-3940256099942544/2934735716',
//         listener: BannerAdListener(
//           onAdLoaded: (Ad ad) {
//             print('$BannerAd loaded.');
//             setState(() {
//               _bannerAdIsLoaded = true;
//             });
//           },
//           onAdFailedToLoad: (Ad ad, LoadAdError error) {
//             print('$BannerAd failedToLoad: $error');
//             ad.dispose();
//           },
//           onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
//           onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
//         ),
//         request: AdRequest())
//       ..load();

//     _nativeAd = NativeAd(
//       adUnitId: Platform.isAndroid
//           ? 'ca-app-pub-3940256099942544/2247696110'
//           : 'ca-app-pub-3940256099942544/3986624511',
//       request: AdRequest(),
//       factoryId: 'adFactoryExample',
//       listener: NativeAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$NativeAd loaded.');
//           setState(() {
//             _nativeAdIsLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$NativeAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
//       ),
//     )..load();

//     _adManagerBannerAd = AdManagerBannerAd(
//       adUnitId: '/6499/example/banner',
//       request: AdManagerAdRequest(nonPersonalizedAds: true),
//       sizes: <AdSize>[AdSize.largeBanner],
//       listener: AdManagerBannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('$AdManagerBannerAd loaded.');
//           setState(() {
//             _adManagerBannerAdIsLoaded = true;
//           });
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('$AdManagerBannerAd failedToLoad: $error');
//           ad.dispose();
//         },
//         onAdOpened: (Ad ad) => print('$AdManagerBannerAd onAdOpened.'),
//         onAdClosed: (Ad ad) => print('$AdManagerBannerAd onAdClosed.'),
//       ),
//     )..load();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _bannerAd?.dispose();
//     _adManagerBannerAd?.dispose();
//     _nativeAd?.dispose();
//   }
// }
