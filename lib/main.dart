// @dart=2.9
import 'package:ffdiamonds/auth/intro.dart';
import 'package:ffdiamonds/auth/welcome.dart';
import 'package:ffdiamonds/screens/navigation.dart';
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        'This channel is used for important notifications.',
        importance: Importance.high);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
  }
  await setCustom();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseDatabase db = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool loggedIn = false;

  // setCustom() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   intro = prefs.getString('intro') == null ? true : false;
  //   await db
  //       .reference()
  //       .child("custom")
  //       .once()
  //       .then((DataSnapshot dataSnapshot) async {
  //     custom = await dataSnapshot.value;
  //   });

  //   await messaging.getToken().then((value) {
  //     fcm = value;
  //   });
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();

    if (_auth.currentUser != null) {
      setState(() {
        loggedIn = true;
      });
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: 'launch_background',
              ),
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'JosefinSans',
            primaryColor: primaryColor,
            primarySwatch: Colors.teal),
        title: 'FFDiamonds',
        debugShowCheckedModeBanner: false,
        home: loggedIn
            ? Nav()
            : intro
                ? Intro()
                : Welcome());
  }
}
