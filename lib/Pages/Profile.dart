import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  Profile({@required this.username});

  final username;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var userData;
  String _name = "Name",
      _collegeName = "College Name",
      _graduationYear = "GraduationYear";

  _getUserData() async {
    userData =
        Firestore.instance.collection("UserData").document(widget.username);
    await userData.get().then((docInstance) {
      setState(() {
        _name = docInstance.data["name"];
        _collegeName = docInstance.data["collegeName"];
        _graduationYear = docInstance.data["graduationYear"];
      });
    });
  }

  @override
  void initState() {
    _getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.red],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
                child: CircleAvatar(
                  child: Text(
                    "${_name[0].toUpperCase()}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxRadius: 30,
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Table(
                    children: _tableBuilder(),
                    // border: TableBorder.all(
                    //   color: Colors.purple,
                    //   width: 2,
                    //   style: BorderStyle.solid,
                    // ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _tableBuilder() {
    return [
      _tableRowBuilder("Name", "$_name"),
      _tableRowBuilder("Username", "${widget.username}"),
      _tableRowBuilder("From", "$_collegeName"),
      _tableRowBuilder("Batch of", "$_graduationYear"),
    ];
  }

  TableRow _tableRowBuilder(String parameter, String value) {
    return TableRow(
      children: [
        _tableCellBuilder("$parameter"),
        _tableCellBuilder(" : "),
        _tableCellBuilder("$value"),
      ],
    );
  }

  Widget _tableCellBuilder(String value) {
    return TableCell(
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      verticalAlignment: TableCellVerticalAlignment.middle,
    );
  }
}
