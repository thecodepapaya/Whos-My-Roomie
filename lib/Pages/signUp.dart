import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'dart:core';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _stackIndex = 0;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _collegeDetailsNameController = TextEditingController();
  TextEditingController _collegeDetailsYearController = TextEditingController();

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
            child: Column(
              children: <Widget>[
                Image.asset("assets/icon.png"),
                Text("What shall we call you?"),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: TextFormField(
                    controller: _nameController,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(
                        RegExp("[a-zA-Z\ ]"),
                      ),
                    ],
                    validator: (String name) {
                      if (name == "" || name == " ") {
                        return "Name cannot be omitted!";
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      labelText: "Name",
                      //errorText: _nameController.text == ""? "Name cannot be empty!": null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          persistentFooterButtons: persistentFooterButtonsBuilder(1),
        ),
//############################################ UsernamePage ############################################################
        Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                Image.asset("assets/icon.png"),
                Text("What shall we call you(username)?"),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: TextFormField(
                    controller: _usernameController,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(
                        RegExp("[a-zA-Z0-9\_\.\-\@\#\$]"),
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: "Name",
                      errorText: _usernameController.text == ""
                          ? "Name cannot be empty!"
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          persistentFooterButtons: persistentFooterButtonsBuilder(2),
        ),
//############################################ PasswordPage ############################################################
        Scaffold(
          body: Center(
            child: Column(
              children: <Widget>[
                Image.asset("assets/icon.png"),
                Text("Set your password"),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: TextFormField(
                    controller: _passwordController,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter(
                        RegExp("[a-zA-Z0-9\!\@\#\$\%\&\*\_\.\+\-\?]"),
                      ),
                    ],
                    decoration: InputDecoration(
                      labelText: "Password",
                      errorText: _usernameController.text == ""
                          ? "Password cannot be empty!"
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          persistentFooterButtons: persistentFooterButtonsBuilder(3),
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
                        "Enter your",
                      ),
                      Text(
                        " College ",
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      Text(
                        "Institute",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(" Details")
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: TextFormField(
                      controller: _collegeDetailsNameController,
                      decoration: InputDecoration(
                        labelText: "Isntitute Name",
                        errorText: _usernameController.text == ""
                            ? "Institute name cannot be empty!"
                            : null,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: TextFormField(
                      controller: _collegeDetailsYearController,
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
                      decoration: InputDecoration(
                        labelText: "Graduation Year",
                        //errorText: _usernameController.text == ""? "Graduation Year cannot be empty!": null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          persistentFooterButtons: persistentFooterButtonsBuilder(4),
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
