import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  Profile({
    @required this.username,
    // @required this.name,
    // @required this.collegeName,
    // @required this.graduationYear,
  });

  final username; //, collegeName, graduationYear, name;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DocumentReference userData;
  String _name;
  String _collegeName;
  String _graduationYear;
  String _gender;
  String _cleanliness;
  String _sleepingSchedule;
  String _cporcpi;
  String _gamer;
  String _studyHabits;
  String _personalBelongings;
  String _diet;
  String _bathing;
  String _socialBehaviour;
  String _acousticProperties;
  String _tvWatcher;

  _getUserData() async {
    userData =
        Firestore.instance.collection("UserData").document(widget.username);
    await userData.get().then((docInstance) {
      setState(() {
        _name = docInstance['name'];
        _collegeName = docInstance['collegeName'];
        _graduationYear = docInstance['graduationYear'];
        _gender = docInstance['Your gender'];
        _cleanliness = docInstance['Cleanliness Habits'];
        _sleepingSchedule = docInstance['Sleeping habits'];
        _cporcpi = docInstance['CP vs CPI'];
        _gamer = docInstance['Gaming habits'];
        _studyHabits = docInstance['Study Habits'];
        _personalBelongings = docInstance['Sharing Habits'];
        _diet = docInstance['Dietary Habits'];
        _bathing = docInstance['Bathing Habits'];
        _socialBehaviour = docInstance['Social Behavious'];
        _acousticProperties = docInstance['Noisy-ness'];
        _tvWatcher = docInstance['Movie Mania'];
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
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [Colors.blue, Colors.red],
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //   ),
        // ),
        child: Center(
          // child: Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.fromLTRB(30, 50, 30, 20),
          //   child: CircleAvatar(
          //     child: Text(
          //       "${_name[0].toUpperCase()}",
          //       style: TextStyle(
          //         fontSize: 25,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //     maxRadius: 30,
          //   ),
          // ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
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
                Padding(
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
              ],
            ),
            //   ),
            // ],
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
      _tableRowBuilder("Your gender", "$_gender"),
      _tableRowBuilder("Cleanliness Habits", "$_cleanliness"),
      _tableRowBuilder("Sleeping habits", "$_sleepingSchedule"),
      _tableRowBuilder("CP vs CPI", "$_cporcpi"),
      _tableRowBuilder("Gaming habits", "$_gamer"),
      _tableRowBuilder("Study Habits", "$_studyHabits"),
      _tableRowBuilder("Sharing Habits", "$_personalBelongings"),
      _tableRowBuilder("Dietary Habits", "$_diet"),
      _tableRowBuilder("Bathing Habits", "$_bathing"),
      _tableRowBuilder("Social Behavious", "$_socialBehaviour"),
      _tableRowBuilder("Noisy-ness", "$_acousticProperties"),
      _tableRowBuilder("Movie Mania", "$_tvWatcher"),
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
        ),
      ),
      verticalAlignment: TableCellVerticalAlignment.middle,
    );
  }
}
