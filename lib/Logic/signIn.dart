import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn {
  String username, password;
  var signInSearch;

  SignIn(String enteredUsername, String enteredPassword) {
    this.username = enteredUsername;
    this.password = enteredPassword;
    signInSearch = 
        Firestore.instance.collection("LoginData").document(username);
  }

  // bool usernameExists() {
  //   if (signInSearch.get() != null) {
  //     return true;
  //   }
  //   return false;
  // }

  bool itsAMatch() {
    var num = 1;
    signInSearch.get().then((documentInstance) {
      if (documentInstance.data['password'] == password) {
        print("Username and Password Match");
        num = 1;
        return true;
      } else {
        print("Username and Password DO NOT Match");
        num = 0;
        return false;
      }
    });
    return (num == 1) ? true : false;
  }
}
