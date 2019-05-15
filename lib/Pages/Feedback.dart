import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';

class Feedback extends StatefulWidget {
  Feedback({Key key, this.username});

  final String username;

  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  var feedback;

  TextEditingController _feedbackController;
  int _starRating = 5;

  @override
  void initState() {
    super.initState();
    _feedbackController = TextEditingController();
    feedback = Firestore.instance
        .collection("Feedbacks")
        .document(DateTime.now().toString());
    print("Collected username for feedback: ${widget.username}");
  }

  @override
  void dispose() {
    _feedbackController.dispose();
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
                padding: EdgeInsets.fromLTRB(40, 40, 40, 20),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "How many star would you like to give us?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    _starRowBuilder(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                child: TextField(
                  autocorrect: true,
                  controller: _feedbackController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: null,
                  decoration: InputDecoration(
                    labelText: "Your Feedback",
                    helperText: "Tell us what you feel :)",
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        _feedbackController.clear();
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

  Widget _starRowBuilder() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _starBuilder(1),
        _starBuilder(2),
        _starBuilder(3),
        _starBuilder(4),
        _starBuilder(5),
      ],
    );
  }

  Widget _starBuilder(int _starnumber) {
    return IconButton(
      onPressed: () {
        setState(() {
          _starRating = _starnumber;
        });
      },
      icon: _starnumber <= _starRating
          ? Icon(Icons.star)
          : Icon(Icons.star_border),
    );
  }

  _checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected to internet, sending feedback');
        _sendFeedback();
        _thankYouDialog();
      }
    } on SocketException catch (_) {
      print('not connected');
      _noInternetDialog();
    }
  }

  void _sendFeedback() {
    feedback.setData({
      'stars': _starRating,
      'feedback': _feedbackController.text,
      'username': widget.username,
    }).then((_) {
      print("Feedback sent");
      _feedbackController.clear();
      Fluttertoast.showToast(
        msg: "Feedback Sent",
        backgroundColor: Colors.white70,
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.black,
      );
    });
    // }).then(() {
    //   print("Feedback sent");
    //   _feedbackController.clear();
    //   Fluttertoast.showToast(
    //     msg: "Feedback Sent",
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
            "You are awesome !\nThank You for your feedback :)",
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
