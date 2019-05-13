import 'package:flutter/material.dart';

class CollegeDetailsPage extends StatefulWidget {
  @override
  CollegeDetailsPageState createState() => CollegeDetailsPageState();
}

class CollegeDetailsPageState extends State<CollegeDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
      // Padding(
      //   padding: EdgeInsets.all(3),
      //   child: CircleAvatar(
      //     maxRadius: 5,
      //     minRadius: 3,
      //     backgroundColor: _pageindex == 1 ? Colors.purple : Colors.blue,
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(3),
      //   child: CircleAvatar(
      //     maxRadius: 5,
      //     minRadius: 3,
      //     backgroundColor: _pageindex == 2 ? Colors.purple : Colors.blue,
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(3),
      //   child: CircleAvatar(
      //     maxRadius: 5,
      //     minRadius: 3,
      //     backgroundColor: _pageindex == 3 ? Colors.purple : Colors.blue,
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(3),
      //   child: CircleAvatar(
      //     maxRadius: 5,
      //     minRadius: 3,
      //     backgroundColor: _pageindex == 4 ? Colors.purple : Colors.blue,
      //   ),
      // ),
      // Padding(
      //   padding: EdgeInsets.all(3),
      //   child: CircleAvatar(
      //     maxRadius: 5,
      //     minRadius: 3,
      //     backgroundColor: _pageindex == 5 ? Colors.purple : Colors.blue,
      //   ),
      // ),
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
