import 'package:ffdiamonds/screens/home.dart';
import 'package:ffdiamonds/screens/profile.dart';
import 'package:ffdiamonds/screens/wallet.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> with AutomaticKeepAliveClientMixin<Nav> {
  @override
  bool get wantKeepAlive => true;

  List<Widget> pages = <Widget>[Home(), Wallet(), Profile()];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: pages[_index],
        bottomNavigationBar: FloatingNavbar(
          itemBorderRadius: 100,
          borderRadius: 20,
          selectedBackgroundColor: Colors.black,
          selectedItemColor: Colors.grey,
          onTap: (int val) => setState(() => _index = val),
          currentIndex: _index,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.wallet_giftcard, title: 'Wallet'),
            FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
          ],
        ),
      ),
    );
  }
}
