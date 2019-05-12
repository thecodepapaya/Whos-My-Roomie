import 'package:flutter/material.dart';
import 'package:whos_my_roomie/Logic/signIn.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  final _userName = TextEditingController();
  final _password = TextEditingController();

  bool _passwordMatch = true;
  bool _usernameFound = true;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
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
            controller: _userName,
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
                var user = new SignIn(_userName.text, _password.text);
                _passwordMatch = user.itsAMatch();
                print("Password Match in First Page: $_passwordMatch");
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
                Navigator.of(context).pushReplacementNamed('/SignUp');
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

  // SizedBox buildFlatButtons(String buttonText) {
  //   return SizedBox(
  //     height: 35,
  //     width: 200,
  //     child: FlatButton(
  //       child: Text(
  //         buttonText,
  //         style: TextStyle(
  //           color: Colors.white,
  //         ),
  //       ),
  //       onPressed: () {
  //         if (buttonText == "Sign In") {
  //           var User = new SignIn(_userName.text, _password.text);
  //           _passwordMatch = User.itsAMatch();
  //           return;
  //         } else {
  //           Navigator.of(context).pushNamed('/SignUp');
  //         }
  //       },
  //       color: Colors.blue,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //     ),
  //   );
  // }
}
