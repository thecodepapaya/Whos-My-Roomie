import 'package:flutter/material.dart';
import 'package:whos_my_roomie/Pages/Dashboard.dart';
import "package:whos_my_roomie/Pages/firstPage.dart";
import 'package:whos_my_roomie/Pages/fillForm.dart';
import 'package:whos_my_roomie/Pages/signUp.dart';
import 'package:page_transition/page_transition.dart';

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
        //'/Dashboard': (BuildContext context) => new Dashboard(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/Dashboard':
            return PageTransition(
              child: Dashboard(),
              type: PageTransitionType.fade,
            );
            break;
          default:
            return null;
        }
      },
    );
  }
}
