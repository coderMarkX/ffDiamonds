// @dart=2.9
import 'package:ffdiamonds/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Intro extends StatelessWidget {
  final pages = [
    PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        // iconImageAssetPath: 'assets/air-hostess.png',
        // bubble: Image.asset('assets/air-hostess.png'),
        body: const Text(
            'Hassle-free  booking  of  flight  tickets  with  full  refund  on  cancellation'),
        title: const Text('Flights'),
        titleTextStyle:
            const TextStyle(fontFamily: 'MyFont', color: Colors.white),
        bodyTextStyle:
            const TextStyle(fontFamily: 'MyFont', color: Colors.white),
        mainImage: Text("A")
        // Image.asset(
        //   'assets/airplane.png',
        //   height: 285.0,
        //   width: 285.0,
        //   alignment: Alignment.center,
        // ),
        ),
    PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      // iconImageAssetPath: 'assets/waiter.png',
      body: const Text(
          'We  work  for  the  comfort ,  enjoy  your  stay  at  our  beautiful  hotels'),
      title: const Text('Hotels'),
      mainImage: Text("B"),
      // Image.asset(
      //   'assets/hotel.png',
      //   height: 285.0,
      //   width: 285.0,
      //   alignment: Alignment.center,
      // ),
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
              Colors.orange,
              Colors.pinkAccent,
            ],
          ),
        ),
      ),
      // iconImageAssetPath: 'assets/taxi-driver.png',
      body: const Text(
        'Easy  cab  booking  at  your  doorstep  with  cashless  payment  system',
      ),
      title: const Text('Cabs'),
      mainImage: Text("C"),
      // mainImage: Image.asset(
      //   'assets/taxi.png',
      //   height: 285.0,
      //   width: 285.0,
      //   alignment: Alignment.center,
      // ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
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
      ),
    );
  }
}
