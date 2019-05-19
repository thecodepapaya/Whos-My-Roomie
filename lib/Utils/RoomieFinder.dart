import 'package:cloud_firestore/cloud_firestore.dart';

class RoomieFinder {
  String _username, _name, _graduationYear, _collegeName;
  int _compatibility;
  DocumentReference userdata;

  RoomieFinder(String username) {
    this._name = "Name";
    this._graduationYear = "YEAR";
    this._collegeName = "College Name";
    this._username = username;
    _compatibility = 0;
    userdata = Firestore.instance.collection("UserData").document(_username);
  }

  int roommateCompatibility() {
    return 91;
  }
}
