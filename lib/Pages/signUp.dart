import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:core';
import 'package:fluttertoast/fluttertoast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _stackIndex = 0;

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
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _stackIndex,
      children: <Widget>[
        Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(50),
                  child: Text("Creating an account will only take a minute"),
                ),
                Padding(
                  padding: EdgeInsets.all(50),
                  child: MaterialButton(
                    color: Colors.blue,
                    child: Text("Get Started"),
                    onPressed: () {
                      //Navigator.pushNamed(context, '/NamePage');
                      setState(() {
                        _stackIndex++;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
//############################################ NamePage ################################################################
        Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset("assets/icon.png"),
                  Text("What shall we call you?"),
                  Form(
                    autovalidate: _autoValidateName,
                    key: _formKeyName,
                    // onChanged: () {
                    //   if (_formKeyName.currentState.validate()) {
                    //     _formKeyName.currentState.save();
                    //   } else {
                    //     setState(() {
                    //       _autoValidateName = true;
                    //     });
                    //   }
                    // },
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: TextFormField(
                        controller: _nameController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter(
                            RegExp("[a-zA-Z\ ]"),
                          ),
                        ],
                        validator: (String _name) {
                          if (_name.contains(RegExp("[\ ]")) == true) {
                            return null;
                          } else {
                            return "Please enter full name";
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
                //_autoValidateName = false;
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
        ),
//############################################ UsernamePage ############################################################
        Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset("assets/icon.png"),
                  Text("Get unique username"),
                  Form(
                    autovalidate: _autoValidateUsername,
                    key: _formKeyUsername,
                    // onChanged: () {
                    //   if (_formKeyName.currentState.validate()) {
                    //     _formKeyName.currentState.save();
                    //   } else {
                    //     setState(() {
                    //       _autoValidateName = true;
                    //     });
                    //   }
                    // },
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: TextFormField(
                        controller: _usernameController,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter(
                            RegExp("[a-zA-Z0-9\@\!\#\$\%\*\.\-\_\=\+\?\]"),
                          ),
                        ],
                        validator: (String _username) {
                          // if (_username.contains(RegExp("[\ ]")) == true) {
                          //   return null;
                          // } else {
                          //   return "Please enter full name";
                          // }
                        },
                        onFieldSubmitted: (_) {
                          if (_formKeyUsername.currentState.validate()) {
                            _formKeyUsername.currentState.save();
                          } else {
                            setState(() {
                              _autoValidateUsername = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Username",
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
                //_autoValidateName = false;
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
                if (_formKeyUsername.currentState.validate()) {
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
        ),
//############################################ PasswordPage ############################################################
        Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset("assets/icon.png"),
                  Text("Choose a password"),
                  Form(
                    autovalidate: _autoValidatePassword,
                    key: _formKeyPassword,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(40),
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40),
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
        ),
//############################################ CollegeDetailsPage ############################################################
        Scaffold(
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  Image.asset("assets/icon.png"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Enter your ",
                      ),
                      Text(
                        "College",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        " Institute",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(" Details")
                    ],
                  ),
                  Form(
                    key: _formKeyCollege,
                    autovalidate: _autoValidateCollege,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(40),
                          child: TextFormField(
                            controller: _collegeDetailsNameController,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter(
                                  RegExp("[a-zA-Z0-9\,\(\)\-]")),
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
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40),
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
                                //print("Correct Year: ${_collegeDetailsYearController.text}");
                              } else {
                                setState(() {
                                  _autoValidateCollege = true;
                                  //print("Incorrect Year");
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Graduation Year",
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
                  //_autoValidateCollege = false;
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
        ),
      ],
    );
  }

  List<Widget> persistentFooterButtonsBuilder(int _pageIndex) {
    return [
      MaterialButton(
        textColor: Colors.white,
        onPressed: () {
          //Navigator.pop(context);
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
        child: _dotPageIndicator(_pageIndex),
      ),
      MaterialButton(
        textColor: Colors.white,
        onPressed: () {
          //Navigator.pushNamed(context, '/PasswordPage');
          // if (_pageIndex == 4) {
          //   if (_formKeyCollege.currentState.validate()) {
          //     setState(() {
          //       _stackIndex++;
          //     });
          //   } else {
          //     Fluttertoast.showToast(
          //       msg: "Invalid Values",
          //       backgroundColor: Colors.white30,
          //       gravity: ToastGravity.BOTTOM,
          //       textColor: Colors.black,
          //     );
          //   }
          // }
          setState(() {
            _stackIndex++;
          });
        },
        child: Text("Next"),
        color: Colors.blueAccent,
        elevation: 7,
      ),
    ];
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
}
