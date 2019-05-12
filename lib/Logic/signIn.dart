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

  bool itsAMatch(){
    signInSearch.get().then((documentInstance){
      if(documentInstance.exists){
        if(documentInstance.data['password'] == password){
          return true;
        }
        else
        {
          return false;
        }
      }
    });
    return false;
  }

  // bool itsAMatch() {
  //   signInSearch.get().then((documentInstance) {
  //     if (documentInstance.exists) {
  //       print("Username and Password Match");
  //       return true;
  //     } else {
  //       print("Username and Password DO NOT Match");
  //       return false;
  //     }
  //   });
  // }
}
