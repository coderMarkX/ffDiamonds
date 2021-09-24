// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final db = FirebaseDatabase.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static getUser() {
    return _auth.currentUser.uid;
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

  static getDataStream(String key, String key2) {
    return db.reference().child(key).reference().child(key2).onValue;
  }

  static logout() {
    return _auth.signOut();
  }
}
