// @dart=2.9
import 'package:ffdiamonds/utils/globadData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

final db = FirebaseDatabase.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;
final currUser = _auth.currentUser;
var messaging = FirebaseMessaging.instance;
bool intro = false;

class FBService {
  static User getUser() {
    return _auth.currentUser;
  }

  static getData(String key) {
    return db.reference().child(key).once();
  }

  static getInsideData(String key, String key2) {
    return db.reference().child(key).reference().child(key2).once();
  }

  static updateData(String key, String key2, var data) {
    return db.reference().child(key).child(key2).update(data);
  }

  static updateData2(String key, String key2, String key3, var data) {
    return db.reference().child(key).child(key2).child(key3).update(data);
  }

  static getDataStream(String key, String key2) {
    return db.reference().child(key).reference().child(key2).onValue;
  }

  static getDataStreamOnly(String key) {
    return db.reference().child(key).onValue;
  }

  static logout() {
    return _auth.signOut();
  }
}

setCustom() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  intro = prefs.getString('intro') == null ? true : false;
  await db
      .reference()
      .child("custom")
      .once()
      .then((DataSnapshot dataSnapshot) async {
    custom = await dataSnapshot.value;
  });

  await messaging.getToken().then((value) {
    fcm = value;
  });
}

setUser() async {
  await FBService.getInsideData('user', FBService.getUser().uid)
      .then((dataSnapshot) async {
    userData = dataSnapshot.value;
  });
}
