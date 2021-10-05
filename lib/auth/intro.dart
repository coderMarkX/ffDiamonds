// @dart=2.9
import 'package:ffdiamonds/auth/welcome.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatelessWidget {
  final pages = [
    PageViewModel(
            pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
             secondaryColor,
               primaryColor,
            ],
          ),
        ),
      ),
 
        title: Text('Earn Diamonds', style: TextStyle(fontFamily: 'JusticeLeague')),
        titleTextStyle:
            const TextStyle(fontFamily: 'MyFont', color: Colors.white),
        bodyTextStyle:
            const TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: 
                  Container(height: 200, child: Lottie.asset("assets/animation/earn.json")),
        ),
    PageViewModel(
             pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
                        Colors.orange,
              Colors.pinkAccent,
  
   
            ],
          ),
        ),
      ),
      body: const Text(
          'Boost Your Youtube Channel', style: TextStyle(fontSize: 30, fontFamily: 'JusticeLeague'),),
      // title: const Text('Boost Youtube'),
        mainImage: 
                  Container(height: 200, child: Lottie.asset("assets/animation/loading.json")),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageBackground: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0],
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            tileMode: TileMode.repeated,
            colors: [
                           primaryColor,
             secondaryColor,
            ],
          ),
        ),
      ),

      title: const Text('Share', style: TextStyle( fontFamily: 'JusticeLeague')),
        mainImage: 
                  Container(height: 200, child: Lottie.asset("assets/animation/share.json")),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return
     Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapDoneButton: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('intro', '1');
            await Navigator.push(
                context, MaterialPageRoute(builder: (_) => Welcome()));
          },
          pageButtonTextStyles: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      
    );
  }
}
