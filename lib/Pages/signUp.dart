import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _securityPin = TextEditingController();
  TextEditingController _college = TextEditingController();
  TextEditingController _graduationYear = TextEditingController();

  var signUpdata = Firestore.instance.collection("LoginData");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "assets/icon.png",
              color: Colors.black87,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 25,bottom: 40),
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 40,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  nameBuilder(),
                  usernameBuilder(),
                  passwordBuilder(),
                  securityPinBuilder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget nameBuilder() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      child: TextFormField(
        controller: _name,
        autofocus: true,
        maxLength: 20,
        decoration: InputDecoration(
          labelText: "Name",
          errorText: "Name cannot be null!",
          filled: true,
          fillColor: Colors.black12,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              style: BorderStyle.solid,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
      ),
    );
  }

  Widget usernameBuilder() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      child: TextFormField(
        controller: _username,
        maxLength: 10,
      ),
    );
  }

  Widget passwordBuilder() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      child: TextFormField(
        controller: _password,
        maxLength: 12,
      ),
    );
  }

  Widget securityPinBuilder() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
      child: TextFormField(
        controller: _securityPin,
        maxLength: 4,
        decoration: InputDecoration(
          labelText: "Security Pin",
        ),
      ),
    );
  }

  

}
