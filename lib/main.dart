import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whos_my_roomie/Pages/Dashboard.dart';
import "package:whos_my_roomie/Pages/firstPage.dart";
import 'package:whos_my_roomie/Pages/fillForm.dart';
import 'package:whos_my_roomie/Pages/signUp.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _savedUsername;
  bool _enableDarkTheme = false;
  SharedPreferences pref;

  void _getSavedPref() async {
    pref = await SharedPreferences.getInstance();
    _savedUsername = pref.getString("username") ?? "Guest Login";
    setState(() {
      _enableDarkTheme = pref.getBool("darkTheme") ?? false;
    });
    print("darkTheme in _getSavedPrefs in main: $_enableDarkTheme");
  }

  @override
  void initState() {
    super.initState();
    _getSavedPref();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Who's My Roomie?",
      debugShowCheckedModeBanner: false,
      theme: _enableDarkTheme
          ? ThemeData.dark()
          : ThemeData(
              primarySwatch: Colors.blue,
            ),
      home: FirstPage(),
      routes: <String, WidgetBuilder>{
        //'/FillForm': (BuildContext context) => new FillForm(),
        '/SignUp': (BuildContext context) => new SignUp(),
        //'/Feedback': (BuildContext context) => new Feedback(),
        //'/Dashboard': (BuildContext context) => new Dashboard(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/Dashboard':
            return PageTransition(
              child: Dashboard(username: _savedUsername),
              type: PageTransitionType.fade,
            );
            break;
          case '/FirstPage':
            return PageTransition(
              child: FirstPage(),
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

// class MyApp extends StatelessWidget {
//   String _savedUsername;

//   void _getSavedPref() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     _savedUsername = pref.getString("username") ?? "Guest Login";
//   }

//   @override
//   Widget build(BuildContext context) {
//     _getSavedPref();
//     return MaterialApp(
//       title: "Who's My Roomie?",
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       //theme: ThemeData.dark(),
//       home: FirstPage(),
//       routes: <String, WidgetBuilder>{
//         '/FillForm': (BuildContext context) => new FillForm(),
//         '/SignUp': (BuildContext context) => new SignUp(),
//         //'/Feedback': (BuildContext context) => new Feedback(),
//         //'/Dashboard': (BuildContext context) => new Dashboard(),
//       },
//       onGenerateRoute: (settings) {
//         switch (settings.name) {
//           case '/Dashboard':
//             return PageTransition(
//               child: Dashboard(username: _savedUsername),
//               type: PageTransitionType.fade,
//             );
//             break;
//           case '/FirstPage':
//             return PageTransition(
//               child: FirstPage(),
//               type: PageTransitionType.fade,
//             );
//             break;
//           default:
//             return null;
//         }
//       },
//     );
//   }
// }
