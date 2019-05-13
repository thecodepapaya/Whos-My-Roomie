import 'package:flutter/material.dart';

class UsernamePage extends StatefulWidget {
  @override
  _UsernamePageState createState() => _UsernamePageState();
}

class _UsernamePageState extends State<UsernamePage> {
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      persistentFooterButtons: <Widget>[
        MaterialButton(
          textColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
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
            Navigator.pushNamed(context, '/PasswordPage');
          },
          child: Text("Next"),
          color: Colors.blueAccent,
          elevation: 7,
        ),
      ],
    );
  }
}

Widget _dotPageIndicator(int _pageindex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      _dotCreater(_pageindex, 1),
      _dotCreater(_pageindex, 2),
      _dotCreater(_pageindex, 3),
      _dotCreater(_pageindex, 4),
      _dotCreater(_pageindex, 5),
    ],
  );
}

Widget _dotCreater(int _pageindex, int _dotNumber) {
  return Padding(
    padding: EdgeInsets.all(3),
    child: CircleAvatar(
      maxRadius: 5,
      minRadius: 3,
      backgroundColor: _pageindex == _dotNumber ? Colors.purple : Colors.blue,
    ),
  );
}
