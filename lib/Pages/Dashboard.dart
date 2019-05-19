import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:share/share.dart';
import 'dart:io';
import 'dart:math';
import 'package:whos_my_roomie/Pages/BugReport.dart' as mybugReport;
import 'package:whos_my_roomie/Pages/Feedback.dart' as myFeedback;
import 'package:whos_my_roomie/Pages/Profile.dart';
import 'package:whos_my_roomie/Utils/RoomieFinder.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, this.username});

  final String username;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  RoomieFinder roomie;

  var documentInstance;
  bool darkMode = false;
  bool _internetConnectivity = false;
  SharedPreferences pref;
  bool _filledForm = true; //make it false when carousel is built

  var _profileName = "Name",
      _collegeName = "College Name",
      _graduationYear = "Year";

  _getThemePrefs() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      darkMode = pref.getBool("darkTheme") ?? false;
    });
    print("darkTheme in _getThemePrefs: $darkMode");
  }

  _checkFilledForm() {
    documentInstance.then((_form) {
      if (_form.data["formfilled"] != true) {
        _filledForm = false;
      } else {
        _filledForm = true;
      }
    });
  }

  _fetchProfileDetails() async {
    _checkInternetConnectivity();
    documentInstance = await Firestore.instance
        .collection("UserData")
        .document(widget.username)
        .get();

    var _profileInstance =
        Firestore.instance.collection("UserData").document(widget.username);
    await _profileInstance.get().then((doc) {
      if (doc.exists) {
        setState(() {
          _profileName = doc.data["name"];
          _collegeName = doc.data["collegeName"];
          _graduationYear = doc.data["graduationYear"];
        });
      } else {
        print("No documents found!");
      }
    }).catchError((onError) {
      print("reached error in _fetchProfileDetails");
    });
    print("Not connected to internet");
  }

  @override
  void initState() {
    _getThemePrefs();
    _checkInternetConnectivity();
    //_checkFilledForm(); // remove comment after carousal is built
    _filledForm =
        true; // for debugging puposes only. Rmeove when carousel is built
    _fetchProfileDetails();
    roomie = RoomieFinder(widget.username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Who's My Roomie?"),
        //backgroundColor: _randomColor(),
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
      stream: Firestore.instance
          .collection('UserData')
          .where("graduationYear", isEqualTo: _graduationYear)
          //.where("filledForm", isEqualTo: "true")
          .orderBy("createdAt", descending: true)
          .snapshots(),
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
            if (snapshot.data.documents.toString() == "[]") {
              // if no student of the same batch is found
              print("documents = [] true");
              return _awSnap();
            }
            if (snapshot.hasError)
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            if (!snapshot.hasData)
              return Center(
                child: Text('No data found!'),
              );

            return Container(
              height: double.infinity,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [_randomColor(), _randomColor()],
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //   ),
              // ),
              child: CarouselSlider(
                height: 400, //MediaQuery.of(context).size.height * 3 / 4,
                enlargeCenterPage: true,
                //autoPlay: true,
                viewportFraction: 0.8,
                enableInfiniteScroll: false,
                autoPlayCurve: Curves.easeIn,
                items: snapshot.data.documents.map(
                  (DocumentSnapshot doc) {
                    return Builder(
                      builder: (BuildContext context) {
                        //function to help build the table on carousel slider cards
                        _tableBuilder() {
                          // return Table(

                          //     children: [
                          //       _tableRowBuilder("Name", "${doc['name']}"),
                          //       _tableRowBuilder(
                          //           "Username", "${doc['username']}"),
                          //       _tableRowBuilder(
                          //           "College", "${doc['collegeName']}"),
                          //       _tableRowBuilder(
                          //           "Batch of", "${doc['graduationYear']}")
                          //     ]);
                          return [
                            _tableRowBuilder("Name", "${doc['name']}"),
                            _tableRowBuilder("Username", "${doc['username']}"),
                            _tableRowBuilder(
                                "College", "${doc['collegeName']}"),
                            _tableRowBuilder(
                                "Batch of", "${doc['graduationYear']}"),
                          ];
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => Profile(
                                      username: doc["username"],
                                      name: doc["name"],
                                      collegeName: doc["collegeName"],
                                      graduationYear: doc["graduationYear"],
                                    ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: _randomColor(),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 4,
                                  offset: Offset(5, 5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 40),
                                    child: Text(
                                      "${doc['name']}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(20),
                                  //   child: CircleAvatar(
                                  //     child: Text(
                                  //       doc["name"][0].toUpperCase(),
                                  //       style: TextStyle(
                                  //         fontSize: 25,
                                  //         fontWeight: FontWeight.w500,
                                  //       ),
                                  //     ),
                                  //     maxRadius: 30,
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: EdgeInsets.all(15),
                                    child: SizedBox(
                                      width: 220,
                                      child: Table(
                                        // defaultColumnWidth:
                                        // IntrinsicColumnWidth(flex: 20),
                                        // columnWidths: Map<1,TableColumnWidth()> columnWidth,
                                        children: _tableBuilder(),
                                        // border: TableBorder.all(
                                        //   color: Colors.purple,
                                        //   width: 2,
                                        //   style: BorderStyle.solid,
                                        // ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Text(
                                      "Compatibility: ${roomie.roommateCompatibility()} %",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  // Text(
                                  //   doc["username"],
                                  //   style: TextStyle(fontSize: 16.0),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  // Text(
                                  //   doc["name"],
                                  //   style: TextStyle(fontSize: 16.0),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  // Text(
                                  //   doc["collegeName"],
                                  //   style: TextStyle(fontSize: 16.0),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  // Text(
                                  //   doc["graduationYear"],
                                  //   style: TextStyle(fontSize: 16.0),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
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
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Profile(username: widget.username);
                    },
                  ),
                );
              },
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
                            _profileName,
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
                            _collegeName,
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
                        Text("Batch of $_graduationYear"),
                      ],
                    ),
                  ],
                ),
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
                  //SystemSound.play(SystemSoundType.click);
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
      }
    } on SocketException catch (_) {
      print('not connected in catch');
      _internetConnectivity = false;
    }
  }

  Widget _awSnap() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 20),
            child: Text(
              "Aw, Snap! :(",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 60, left: 45, right: 45),
            child: Text(
              'It looks like out none of your batchmates have tried this app yet.',
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.share),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Share Now!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              onTap: () {
                Share.share(
                  'Hey! Checkout this awesome app by *bLaCkLiGhT*\nhttps://github.com/ashutoshsingh05/Whos-My-Roomie/',
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // _noInternetWarning() {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Row(
  //           children: <Widget>[
  //             Icon(Icons.warning),
  //             SizedBox(
  //               width: 7,
  //             ),
  //             Text("No Internet"),
  //           ],
  //         ),
  //         content: Text(
  //           "No internet connectivity detected. Please connect to the internet and try again",
  //         ),
  //         actions: <Widget>[
  //           // FlatButton(
  //           //   child: Text("Retry"),
  //           //   onPressed: () {
  //           //     setState(() {
  //           //       Navigator.pop(context);
  //           //     }); // Known BUG: Need to tap 2 times on RETRY to successfully re-build the Screen
  //           //   },
  //           // ),
  //           FlatButton(
  //             child: Text("Exit"),
  //             onPressed: () {
  //               SystemNavigator.pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  TableRow _tableRowBuilder(String parameter, String value) {
    return TableRow(
      children: [
        _tableCellBuilder("$parameter"),
        _tableCellBuilder(" : "),
        _tableCellBuilder("$value"),
      ],
    );
  }

  Widget _tableCellBuilder(String value) {
    return TableCell(
      child: Text(
        value,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      verticalAlignment: TableCellVerticalAlignment.middle,
    );
  }

  _handleLogoutSharedPrefs() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("LoggedIn", false);
    pref.setString("username", null);
  }

  MaterialColor _randomColor() {
    List _colorsList = <MaterialColor>[
      Colors.red,
      Colors.amber,
      Colors.blue,
      Colors.blueGrey,
      Colors.brown,
      Colors.cyan,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.green,
      Colors.grey,
      Colors.indigo,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.lime,
      Colors.orange,
      Colors.pink,
      Colors.purple,
      Colors.teal,
      Colors.yellow,
    ];
    return _colorsList[Random().nextInt(19)];
  }
}
