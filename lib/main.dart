import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Who's My Roomie?",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

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
        onPressed: () {},
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(
                height: 180,
              ),
              FadeTransition(
                opacity: _animation,
                child: Padding(
                  child: buildFlatButtons("Sign In"),
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
              FadeTransition(
                opacity: _animation,
                child: Padding(
                  child: buildFlatButtons("Sign Up"),
                  padding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
