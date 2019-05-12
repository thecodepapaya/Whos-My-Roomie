import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn {
  String username, password;

  var signInSearch =
      Firestore.instance.collection("LoginData").document("ashu");

  SignIn(String enteredUsername, String enteredPassword) {
    this.username = enteredUsername;
    this.password = enteredPassword;
  }

  bool usernameExists() {
    return signInSearch.get() != null;
  }

  bool itsAMatch() {
    if (usernameExists()) {
      signInSearch.get().then((_){
        print(_);
        print(_.data['username']);
      });
      
    }
    return false;
  }
}
