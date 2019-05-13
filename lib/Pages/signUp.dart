import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  int _stackIndex = 0;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _collegeDetailsPageController = TextEditingController();

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
                    decoration: InputDecoration(
                      labelText: "Name",
                      errorText: _nameController.text == ""
                          ? "Name cannot be empty!"
                          : null,
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
          body: Center(
            child: Column(
              children: <Widget>[
                Image.asset("assets/icon.png"),
                Text("Set your password"),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: TextFormField(
                    controller: _collegeDetailsPageController,
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
