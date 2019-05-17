import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'package:whos_my_roomie/Pages/BugReport.dart' as mybugReport;
import 'package:whos_my_roomie/Pages/Feedback.dart' as myFeedback;

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.username});

  final String username;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var documentInstance;
  bool darkMode = false;
  bool _internetConnectivity = false;
  SharedPreferences pref;
  bool _filledForm =
      true; // remember to make it false before  building the final version

  _getThemePrefs() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      darkMode = pref.getBool("darkTheme") ?? false;
    });
    print("darkTheme in _getThemePrefs: $darkMode");
  }

  _getFilledFormDetails() {
    documentInstance.then((_form) {
      if (_form.data["formfilled"] != true) {
        _filledForm = false;
      } else {
        _filledForm = true;
      }
    });
  }

  @override
  void initState() {
    documentInstance = Firestore.instance
        .collection("UserData")
        .document(widget.username)
        .get();
    _getThemePrefs();
    _checkInternetConnectivity();
    _getFilledFormDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Who's My Roomie?"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
            tooltip: "Options",
          ),
        ],
      ),
      drawer: _drawerBuilder(),
      body: _bodyBuilder(),
    );
  }

  Widget _bodyBuilder() {
    return Center(
      child: _internetConnectivity
          ? (_filledForm)
              ? _carouselBuilder()
              : Text("Please fill the form first")
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.warning),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Text(
                    "No Internet !",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Connect to the internet and try restarting the app",
                  ),
                ),
              ],
            ),
    );
  }

  Widget _carouselBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('UserData').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasError)
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            if (!snapshot.hasData)
              return Center(
                child: Text('No data found!'),
              );
            return Container(
              child: CarouselSlider(
                items: snapshot.data.documents.map((DocumentSnapshot doc) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(color: Colors.amber),
                          child: Text(
                            doc["username"],
                            style: TextStyle(fontSize: 16.0),
                          ));
                    },
                  );
                }).toList(),
              ),
            );
        }
      },
    );
  }

  Widget _drawerBuilder() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        child: Text(
                          widget.username[0].toUpperCase(),
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        maxRadius: 25,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          widget.username,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        child: Text(
                          "Ashutosh Singh",
                          overflow: TextOverflow.ellipsis,
                        ),
                        width: MediaQuery.of(context).size.width * 3 / 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                      ),
                      SizedBox(
                        child: Text(
                          "Indian Intitute of Information Technology, Vadodara",
                          overflow: TextOverflow.ellipsis,
                        ),
                        width: MediaQuery.of(context).size.width * 3 / 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                      ),
                      Text("Batch of 2022"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: Text("Dark Mode"),
            trailing: Switch(
              value: darkMode,
              onChanged: (_) {
                print("darkTheme before confirmation Dialog: $darkMode");
                print("_ before confirmation Dialog: $_");
                _showThemeConfirmationDialog();
              },
            ),
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () async {
              return showDialog(
                context: context,
                barrierDismissible: true,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Logout"),
                    content: Text("Are you sure you want to logout?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          _handleLogoutSharedPrefs();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/FirstPage', (Route<dynamic> route) => false);
                        },
                      ),
                      FlatButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
            title: Text("Share this app"),
            subtitle: Text("Liked this app? Spread the word !"),
            onTap: () {
              Share.share(
                'Hey! Checkout this awesome app by *bLaCkLiGhT*\nhttps://github.com/ashutoshsingh05/Whos-My-Roomie/',
              );
            },
          ),
          ListTile(
            title: Text("Give Feedback"),
            subtitle: Text("We'd love to hear from you"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) =>
                      myFeedback.Feedback(username: widget.username),
                ),
              );
            },
          ),
          ListTile(
            title: Text("Report Bug"),
            subtitle: Text("Help us make this app better!"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) =>
                      mybugReport.BugReport(username: widget.username),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Future _showThemeConfirmationDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(Icons.warning),
              SizedBox(width: 7),
              Text("Warning"),
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                setState(() {
                  if (darkMode) {
                    darkMode = false;
                    pref.setBool("darkTheme", darkMode);
                  } else {
                    darkMode = true;
                    pref.setBool("darkTheme", darkMode);
                  }
                  SystemNavigator.pop();
                });
                print("darkTheme after pressing 'OK': $darkMode");
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          content: Text(
            "In order to change the theme you need to restart the app",
          ),
        );
      },
    );
  }

  _checkInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to internet, building carousal');
        setState(() {
          _internetConnectivity = true;
        });
      } else {
        print('not connected in try');
        _internetConnectivity = false;
        return false;
      }
    } on SocketException catch (_) {
      print('not connected in catch');
      _internetConnectivity = false;
      return false;
    }
  }

  _handleLogoutSharedPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("LoggedIn", false);
    pref.setString("username", null);
  }
}
