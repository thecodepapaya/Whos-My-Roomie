import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Who's My Roomie?"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
            tooltip: "Options",
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerHeader(),
      ),
      body: Center(
        child: Text("The Dashboard"),
      ),
    );
  }
}
