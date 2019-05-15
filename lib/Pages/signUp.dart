import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _stackIndex = 0;
  bool _usernameFound = false;
  var _usernameSearch;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();
  TextEditingController _collegeDetailsNameController = TextEditingController();
  TextEditingController _collegeDetailsYearController = TextEditingController();

  bool _autoValidateName = false;
  bool _autoValidateUsername = false;
  bool _autoValidatePassword = false;
  bool _autoValidateCollege = false;

  GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyUsername = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyPassword = GlobalKey<FormState>();
  GlobalKey<FormState> _formKeyCollege = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameSearch = Firestore.instance.collection("LoginData");
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _collegeDetailsNameController.dispose();
    _collegeDetailsYearController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _stackIndex,
      children: <Widget>[
        gettingstarted(),
        namePageBuilder(),
        usernamePageBuilder(),
        passwordPageBuilder(),
        collegeDetailsPageBuilder(),
        signUpSuccessfulBuilder(),
      ],
    );
  }

//############################################ GettingStartedPage ######################################################
  Widget gettingstarted() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                "assets/HuggingFaceEmoji.png",
                scale: 3,
              ),
              Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  "It feels so good to have you here",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(50),
                child: MaterialButton(
                  color: Colors.blue,
                  child: Text(
                    "Let's get Started!",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    try {
                      final result = await InternetAddress.lookup('google.com');
                      if (result.isNotEmpty &&
                          result[0].rawAddress.isNotEmpty) {
                        print('Connected, can start SignUp');
                        setState(() {
                          _stackIndex++;
                        });
                      }
                    } on SocketException catch (_) {
                      print('not connected, cannot start signUp');
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
                              "You must be connected to the internet to SignUp.",
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//############################################ NamePage ################################################################
  Widget namePageBuilder() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset("assets/SmilingEmojiwithSmilingEyes.png"),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "What shall we call you?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Form(
                autovalidate: _autoValidateName,
                key: _formKeyName,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
                  child: TextFormField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(
                        RegExp("[a-zA-Z\ ]"),
                      ),
                    ],
                    validator: (String _name) {
                      if (_name.contains(RegExp("[\ ]")) == true) {
                        return null;
                      } else {
                        return "Please enter your full name";
                      }
                    },
                    onFieldSubmitted: (_) {
                      if (_formKeyName.currentState.validate()) {
                        _formKeyName.currentState.save();
                      } else {
                        setState(() {
                          _autoValidateName = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      //prefixIcon: Icon(Icons.face),
                      icon: Icon(
                        Icons.face,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        MaterialButton(
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _stackIndex--;
            });
          },
          child: Text("Back"),
          color: Colors.blueAccent,
          elevation: 7,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: _dotPageIndicator(1),
        ),
        MaterialButton(
          textColor: Colors.white,
          onPressed: () {
            if (_formKeyName.currentState.validate()) {
              setState(() {
                _stackIndex++;
              });
            } else {
              Fluttertoast.showToast(
                msg: "Invalid Values",
                backgroundColor: Colors.white70,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.black,
              );
            }
          },
          child: Text("Next"),
          color: Colors.blueAccent,
          elevation: 7,
        ),
      ],
    );
  }

//############################################ UsernamePage ############################################################
  Widget usernamePageBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usernameSearch.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        } else {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/SmilingEmojiwithEyesOpened.png"),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Hey! Let's get you a Unique Username",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Form(
                      autovalidate: _autoValidateUsername,
                      key: _formKeyUsername,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 25, horizontal: 40),
                        child: TextFormField(
                          controller: _usernameController,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter(
                              RegExp("[a-zA-Z0-9\@\!\#\$\%\*\.\-\_\=\+\?\]"),
                            ),
                          ],
                          onFieldSubmitted: (_) {
                            _usernameSearch
                                .document(_usernameController.text)
                                .get()
                                .then((documentInstance) {
                              if (!documentInstance.exists) {
                                setState(() {
                                  _usernameFound = false;
                                });
                              } else {
                                setState(() {
                                  _usernameFound = true;
                                });
                              }
                            });
                          },
                          decoration: InputDecoration(
                            labelText: "Username",
                            errorText: _usernameFound
                                ? "Username Already exists"
                                : null,
                            icon: Icon(
                              Icons.verified_user,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            persistentFooterButtons: <Widget>[
              MaterialButton(
                textColor: Colors.white,
                onPressed: () {
                  setState(() {
                    _stackIndex--;
                  });
                },
                child: Text("Back"),
                color: Colors.blueAccent,
                elevation: 7,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: _dotPageIndicator(2),
              ),
              MaterialButton(
                textColor: Colors.white,
                onPressed: () {
                  _usernameSearch
                      .document(_usernameController.text)
                      .get()
                      .then((documentInstance) {
                    if (!documentInstance.exists) {
                      setState(() {
                        _usernameFound = false;
                        _stackIndex++;
                      });
                    } else {
                      setState(() {
                        _usernameFound = true;
                      });
                      Fluttertoast.showToast(
                        msg: "Invalid Values",
                        backgroundColor: Colors.white70,
                        gravity: ToastGravity.BOTTOM,
                        textColor: Colors.black,
                      );
                    }
                  });
                },
                child: Text("Next"),
                color: Colors.blueAccent,
                elevation: 7,
              ),
            ],
          );
        }
      },
    );
  }

//############################################ PasswordPage ############################################################
  Widget passwordPageBuilder() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset("assets/ZipperMouthFaceEmoji.png"),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  "Don't worry, we don't store your Passwords in plain.txt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Form(
                autovalidate: _autoValidatePassword,
                key: _formKeyPassword,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter(
                            RegExp("[a-zA-Z0-9\!\@\#\$\%\&\*\_\.\+\-\?]"),
                          ),
                        ],
                        validator: (String _password) {
                          if (_password.length < 4) {
                            return "Your password is too short";
                          }
                        },
                        onFieldSubmitted: (_) {
                          if (_formKeyPassword.currentState.validate()) {
                            _formKeyPassword.currentState.save();
                          } else {
                            setState(() {
                              _autoValidatePassword = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          icon: Icon(
                            Icons.vpn_key,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
                      child: TextFormField(
                        obscureText: true,
                        controller: _passwordConfirmController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter(
                            RegExp("[a-zA-Z0-9\!\@\#\$\%\&\*\_\.\+\-\?]"),
                          ),
                        ],
                        validator: (String _password) {
                          if (_password != _passwordController.text) {
                            return "Passwords do not match";
                          }
                        },
                        onFieldSubmitted: (_) {
                          if (_formKeyPassword.currentState.validate()) {
                            _formKeyPassword.currentState.save();
                          } else {
                            setState(() {
                              _autoValidatePassword = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Confirm Passoword",
                          icon: Icon(
                            Icons.vpn_key,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        MaterialButton(
          textColor: Colors.white,
          onPressed: () {
            _autoValidatePassword = false;
            setState(() {
              _stackIndex--;
            });
          },
          child: Text("Back"),
          color: Colors.blueAccent,
          elevation: 7,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: _dotPageIndicator(3),
        ),
        MaterialButton(
          textColor: Colors.white,
          onPressed: () {
            if (_formKeyPassword.currentState.validate()) {
              setState(() {
                _stackIndex++;
              });
            } else {
              Fluttertoast.showToast(
                msg: "Invalid Values",
                backgroundColor: Colors.white70,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.black,
              );
            }
          },
          child: Text("Next"),
          color: Colors.blueAccent,
          elevation: 7,
        ),
      ],
    );
  }

//############################################ CollegeDetailsPage ######################################################
  Widget collegeDetailsPageBuilder() {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset("assets/HouseEmoji.png"),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Enter your ",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "College",
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    " Institute",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    " Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                key: _formKeyCollege,
                autovalidate: _autoValidateCollege,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
                      child: TextFormField(
                        controller: _collegeDetailsNameController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter(
                              RegExp("[a-zA-Z0-9\ \,\(\)\-]")),
                        ],
                        validator: (String _name) {
                          if (_name.length == 0) {
                            return "Enter valid Institute name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Isntitute Name",
                          icon: Icon(
                            Icons.home,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 20),
                      child: TextFormField(
                        controller: _collegeDetailsYearController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[0-9]")),
                        ],
                        validator: (String _year) {
                          if (_year.length != 4) {
                            return "Invalid Graduation Year";
                          } else {
                            return null;
                          }
                        },
                        onFieldSubmitted: (_) {
                          if (_formKeyCollege.currentState.validate()) {
                            _formKeyCollege.currentState.save();
                          } else {
                            setState(() {
                              _autoValidateCollege = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Graduation Year",
                          icon: Icon(
                            Icons.calendar_today,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: <Widget>[
        MaterialButton(
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              _stackIndex--;
            });
          },
          child: Text("Back"),
          color: Colors.blueAccent,
          elevation: 7,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.55,
          child: _dotPageIndicator(4),
        ),
        MaterialButton(
          textColor: Colors.white,
          onPressed: () {
            if (_formKeyCollege.currentState.validate()) {
              _handleInternetConnectivity();
              //_pushEverythingToFirebase();
              //_manageSharedPreferences();
            } else {
              Fluttertoast.showToast(
                msg: "Invalid Values",
                backgroundColor: Colors.white70,
                gravity: ToastGravity.BOTTOM,
                textColor: Colors.black,
              );
            }
          },
          child: Text("Next"),
          color: Colors.blueAccent,
          elevation: 7,
        ),
      ],
    );
  }

//############################################ SignUpSuccessfulPage ####################################################
  Widget signUpSuccessfulBuilder() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/green-tick.png",
              scale: 3,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Text(
                "You've Signed up Successfully",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: MaterialButton(
                child: Text("Dashboard"),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Dashboard', (Route<dynamic> route) => false);
                },
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dotPageIndicator(int _pageIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _dotCreater(_pageIndex, 1),
        _dotCreater(_pageIndex, 2),
        _dotCreater(_pageIndex, 3),
        _dotCreater(_pageIndex, 4),
      ],
    );
  }

  Widget _dotCreater(int _pageIndex, int _dotNumber) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: CircleAvatar(
        maxRadius: 5,
        minRadius: 3,
        backgroundColor: _pageIndex == _dotNumber ? Colors.purple : Colors.blue,
      ),
    );
  }

  _handleInternetConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Connected, can SignUp');
        _pushEverythingToFirebase();
        _manageSharedPreferences();
      }
    } on SocketException catch (_) {
      print('not connected, cannot signUp');
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

  void _pushEverythingToFirebase() {
    Firestore.instance
        .collection("LoginData")
        .document(_usernameController.text)
        .setData({
      'username': _usernameController.text,
      'password': _passwordController.text,
    }).then((_) {
      Firestore.instance
          .collection("UserData")
          .document(_usernameController.text)
          .setData({
        'username': _usernameController.text,
        'name': _nameController.text,
        'collegeName': _collegeDetailsNameController.text,
        'graduationYear': _collegeDetailsYearController.text,
      }).then((_) {
        setState(() {
          _stackIndex++;
        });
      });
    });
  }

  void _manageSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("LoggedIn", true);
    pref.setString("username", _usernameController.text);
  }
}
