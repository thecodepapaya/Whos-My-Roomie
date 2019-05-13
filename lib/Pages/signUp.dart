import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

// class SignUp extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }

// class _SignUpState extends State<SignUp> {
//   TextEditingController _username = TextEditingController();
//   TextEditingController _password = TextEditingController();
//   TextEditingController _name = TextEditingController();
//   TextEditingController _securityPin = TextEditingController();
//   TextEditingController _college = TextEditingController();
//   TextEditingController _graduationYear = TextEditingController();

//   var signUpdata = Firestore.instance.collection("LoginData");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Stack(
//           fit: StackFit.expand,
//           children: <Widget>[
//             // Image.asset(
//             //   "assets/icon.png",
//             //   color: Colors.greenAccent,
//             //   fit: BoxFit.cover,
//             //   colorBlendMode: BlendMode.darken,
//             // ),
//             Container(
//               color: Colors.orangeAccent,
//             ),
//             SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(top: 25, bottom: 40),
//                     child: Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontSize: 40,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   nameBuilder(),
//                   usernameBuilder(),
//                   passwordBuilder(),
//                   securityPinBuilder(),
//                   collegeBuilder(),
//                   graduationYearBuilder(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget nameBuilder() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//       child: TextFormField(
//         controller: _name,
//         autofocus: true,
//         maxLength: 20,
//         decoration: InputDecoration(
//           labelText: "Your full name",
//           errorText: (_name.text != null) ? null : "Name cannot be null!",
//           prefixIcon: Icon(Icons.face),
//           filled: true,
//           fillColor: Colors.white70,
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.red,
//               style: BorderStyle.solid,
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(6)),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget usernameBuilder() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//       child: TextFormField(
//         controller: _username,
//         maxLength: 10,
//       ),
//     );
//   }

//   Widget passwordBuilder() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//       child: TextFormField(
//         controller: _password,
//         maxLength: 12,
//       ),
//     );
//   }

//   Widget securityPinBuilder() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//       child: TextFormField(
//         controller: _securityPin,
//         maxLength: 4,
//         decoration: InputDecoration(
//           labelText: "Security Pin",
//         ),
//       ),
//     );
//   }

//   Widget collegeBuilder() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//       child: TextFormField(
//         controller: _college,
//         autofocus: true,
//         maxLength: 20,
//         decoration: InputDecoration(
//           labelText: "College",
//           errorText: "College cannot be null!",
//           filled: true,
//           fillColor: Colors.black12,
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.red,
//               style: BorderStyle.solid,
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(6)),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget graduationYearBuilder() {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
//       child: TextFormField(
//         controller: _graduationYear,
//         autofocus: true,
//         maxLength: 20,
//         decoration: InputDecoration(
//           labelText: "Graduation Year",
//           errorText: "Graduation cannot be null!",
//           filled: true,
//           fillColor: Colors.black12,
//           border: OutlineInputBorder(
//             borderSide: BorderSide(
//               color: Colors.red,
//               style: BorderStyle.solid,
//               width: 2.0,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(6)),
//           ),
//         ),
//       ),
//     );
//   }
// }

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Navigator.pushNamed(context, '/NamePage');
                },
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
          child: _dotPageIndicator(1),
        ),
        MaterialButton(
          textColor: Colors.white,
          onPressed: () {},
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
