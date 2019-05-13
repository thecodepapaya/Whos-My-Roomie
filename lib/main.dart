import 'package:flutter/material.dart';
import "package:whos_my_roomie/Pages/firstPage.dart";
import 'package:whos_my_roomie/Pages/fillForm.dart';
import 'package:whos_my_roomie/Pages/signUp.dart';
// import 'package:whos_my_roomie/Pages/SignUpPages/NamePage.dart';
// import 'package:whos_my_roomie/Pages/SignUpPages/UsernamePage.dart';
// import 'package:whos_my_roomie/Pages/SignUpPages/PasswordPage.dart';
// import 'package:whos_my_roomie/Pages/SignUpPages/CollegeDetailsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Who's My Roomie?",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //theme: ThemeData.dark(),
      home: FirstPage(),
      routes: <String, WidgetBuilder>{
        '/FillForm': (BuildContext context) => new FillForm(),
        '/SignUp': (BuildContext context) => new SignUp(),
        '/Firstpage': (BuildContext context) => new FirstPage(),
        // '/NamePage': (BuildContext context) => new NamePage(),
        // '/UsernamePage': (BuildContext context) => new UsernamePage(),
        // '/PasswordPage': (BuildContext context) => new PasswordPage(),
        // '/CollegeDetailsPage': (BuildContext context) => new CollegeDetailsPage(),
      },
    );
  }
}
