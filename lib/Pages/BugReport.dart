import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class BugReport extends StatefulWidget {
  BugReport({Key key, this.username});

  final String username;

  @override
  _BugReportState createState() => _BugReportState();
}

class _BugReportState extends State<BugReport> {
  var bugReport;

  TextEditingController _descriptionController;
  TextEditingController _modelController;
  TextEditingController _androidVersionController;

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController();
    _modelController = TextEditingController();
    _androidVersionController = TextEditingController();
    bugReport = Firestore.instance
        .collection("BugReports")
        .document(DateTime.now().toString());
    print("Collected username for bugReport: ${widget.username}");
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _modelController.dispose();
    _androidVersionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: Text(
                  "Please fill the following details",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: TextFormField(
                  autocorrect: true,
                  controller: _androidVersionController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(RegExp("[0-9\.]")),
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Android Version",
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _androidVersionController.clear();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: TextFormField(
                  autocorrect: true,
                  controller: _modelController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter(
                        RegExp("[a-zA-Z0-9\ \-\(\)]"))
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Phone Model",
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _modelController.clear();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: TextFormField(
                  autocorrect: true,
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  inputFormatters: <TextInputFormatter>[
                    BlacklistingTextInputFormatter(
                        RegExp("[\*\^\~\`\[\]\{\}\<\>\|]"))
                  ],
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Detailed Description",
                    helperText: "This will help us find the problem easily",
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _descriptionController.clear();
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: MaterialButton(
                  onPressed: () {
                    _checkConnectivity();
                  },
                  child: Icon(Icons.send),
                  color: Colors.blue,
                  height: 50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _starRowBuilder() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       _starBuilder(1),
  //       _starBuilder(2),
  //       _starBuilder(3),
  //       _starBuilder(4),
  //       _starBuilder(5),
  //     ],
  //   );
  // }

  // Widget _starBuilder(int _starnumber) {
  //   return IconButton(
  //     onPressed: () {
  //       setState(() {
  //         _starRating = _starnumber;
  //       });
  //     },
  //     icon: _starnumber <= _starRating
  //         ? Icon(Icons.star)
  //         : Icon(Icons.star_border),
  //   );
  // }

  _checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to internet, sending bugReport');
        _sendbugReport();
        _thankYouDialog();
      }
    } on SocketException catch (_) {
      print('not connected');
      _noInternetDialog();
    }
  }

  void _sendbugReport() {
    bugReport.setData({
      'description': _descriptionController.text,
      'android': _androidVersionController.text,
      'model': _modelController.text,
      'username': widget.username,
    }).then((_) {
      print("bugReport sent");
      _descriptionController.clear();
      _modelController.clear();
      _androidVersionController.clear();
      Fluttertoast.showToast(
        msg: "Bug Report has been sent",
        backgroundColor: Colors.white70,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
      );
    });
    // }).then(() {
    //   print("bugReport sent");
    //   _bugReportController.clear();
    //   Fluttertoast.showToast(
    //     msg: "bugReport Sent",
    //     backgroundColor: Colors.white70,
    //     gravity: ToastGravity.BOTTOM,
    //     textColor: Colors.black,
    //   );
    // });
  }

  Future _thankYouDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thank You"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
          content: Text(
            "You are awesome !\nThank You for the Bug Report :)",
          ),
        );
      },
    );
  }

  Future _noInternetDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("No Internet"),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
          content: Text(
            "You are not conncted to the Internet.",
          ),
        );
      },
    );
  }
}
