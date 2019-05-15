import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share/share.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.username});

  final String username;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var documentInstance;

  @override
  void initState() {
    super.initState();
    documentInstance = Firestore.instance
        .collection("UserData")
        .document(widget.username)
        .get();
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          child: Text(widget.username[0].toUpperCase()),
                          maxRadius: 25,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                            widget.username,
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
              title: Text("Settings"),
              onTap: () {},
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
                Share.share('Hey! Checkout this awesome app by *bLaCkLiGhT*\nhttps://github.com/ashutoshsingh05/Whos-My-Roomie/releases');
              },
            ),
            ListTile(
              title: Text("Give Feedback"),
              subtitle: Text("We'd love to hear from you"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Report Bug"),
              subtitle: Text("Help us make this app better!"),
              onTap: () {},
            )
          ],
        ),
      ),
      body: Center(
        child: Text("The Dashboard"),
      ),
    );
  }

  _handleLogoutSharedPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("LoggedIn", false);
    pref.setString("username", null);
  }
}
