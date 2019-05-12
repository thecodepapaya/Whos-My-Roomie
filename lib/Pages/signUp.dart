import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: Text("Sign Up"),
                padding: EdgeInsets.symmetric(vertical: 25),
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: TextFormField(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
