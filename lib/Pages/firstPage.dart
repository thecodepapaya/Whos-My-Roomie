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
                signInAndButtonBuilder(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signInAndButtonBuilder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          child: TextFormField(
            controller: _userName,
            decoration: InputDecoration(
              labelText: "Username",
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          child: TextFormField(
            controller: _password,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
        ),
        Padding(
          child: buildFlatButtons("Sign In"),
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        Text(
          "\nDon't have an account?",
          textAlign: TextAlign.center,
        ),
        Padding(
          child: buildFlatButtons("Sign Up Now"),
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
      ],
    );
  }

  SizedBox buildFlatButtons(String buttonText) {
    return SizedBox(
      height: 35,
      width: 200,
      child: FlatButton(
        child: Text(
          buttonText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          if (buttonText == "Sign In") {
            var User = new SignIn(_userName.text,_password.text);
          } else {
            Navigator.of(context).pushNamed('/SignUp');
          }
        },
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
