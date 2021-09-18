import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  static final db = FirebaseDatabase.instance;
  static getData(String key) {
    return db.reference().child(key).once();
  }
}
