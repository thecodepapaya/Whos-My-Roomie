import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  final _usernameController = TextEditingController();
  final _password = TextEditingController();

  String storedUsername, storedPassword;

  bool _passwordMatch = true;
  bool _usernameFound = true;

  String _alreadySignedInUsername;

  var signInSearch;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 1500,
      ),
      vsync: this,
      debugLabel: "Animation controller for fading the confused roomie icon",
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    signInSearch = Firestore.instance.collection("LoginData");
    _getSharedPreference();
  }

  @override
  void dispose() {
    _controller.dispose();
    _usernameController.dispose();
    _password.dispose();
    super.dispose();
  }

  void _getSharedPreference() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("LoggedIn") ?? false) {
      _alreadySignedInUsername = pref.getString("username");
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/FillForm',
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: signInSearch.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return Scaffold(
          body: Center(
            child: FadeTransition(
              opacity: _animation,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        FadeTransition(
                          opacity: _animation,
                          child: Image.asset(
                            "assets/icon-full.png",
                            scale: 2,
                          ),
                        ),
                        FadeTransition(
                          opacity: _animation,
                          child: Padding(
                            child: Text(
                              "Who's My Roomie?",
                              textScaleFactor: 2,
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                          ),
                        ),
                      ],
                    ),
                    signInBuilder(),
                    signUpBuilder(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget signInBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 5,
          ),
          child: TextFormField(
            controller: _usernameController,
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter(
                RegExp("[a-zA-Z0-9\@\!\#\$\%\*\.\-\_\=\+\?\]"),
              ),
            ],
            decoration: InputDecoration(
              labelText: "Username",
              errorText: _usernameFound ? null : 'Username not found !',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 5,
          ),
          child: TextFormField(
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              errorText: _passwordMatch
                  ? null
                  : 'Username and Password do not Match !',
            ),
          ),
        ),
        Padding(
          child: SizedBox(
            height: 35,
            width: 200,
            child: FlatButton(
              child: Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                signInSearch
                    .document(_usernameController.text)
                    .get()
                    .then((documentInstance) {
                  if (!documentInstance.exists) {
                    setState(() {
                      _usernameFound = false;
                    });
                  } else {
                    _usernameFound = true;
                    storedPassword = documentInstance.data["password"];
                    if (_signIn(storedPassword, _password.text)) {
                      _passwordMatch = true;
                      _setSharedPreferences();
                      Navigator.pushReplacementNamed(context, '/FillForm');
                    } else {
                      setState(() {
                        _passwordMatch = false;
                      });
                    }
                  }
                });
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
      ],
    );
  }

  Widget signUpBuilder() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            "Don't have an account?",
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            height: 35,
            width: 200,
            child: FlatButton(
              child: Text(
                "Sign Up Now!",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/SignUp');
              },
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _signIn(String storedPassword, String password) {
    if (storedPassword == password) {
      print("Logged IN");
      return true;
    } else {
      print("Not Logged in");
      return false;
    }
  }

  void _setSharedPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("LoggedIn", true);
    pref.setString("username", _usernameController.text);
  }
}
