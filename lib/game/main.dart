// @dart=2.9
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/material.dart';
import './gamer/gamer.dart';
import './material/audios.dart';
import './panel/page_portrait.dart';
import 'gamer/keyboard.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyGame extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'JosefinSans',
          primaryColor: primaryColor,
          primarySwatch: Colors.teal),
      title: 'FFDiamonds',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Sound(child: Game(child: KeyboardController(child: _HomePage()))),
      ),
    );
  }
}

const SCREEN_BORDER_WIDTH = 3.0;
const BACKGROUND_COLOR = primaryColor;
// const BACKGROUND_COLOR = const Color(0xffefcc19);

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //only Android/iOS support land mode
    bool land = MediaQuery.of(context).orientation == Orientation.landscape;
    return land ? PageLand() : PagePortrait();
  }
}
