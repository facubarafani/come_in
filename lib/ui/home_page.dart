import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
        centerTitle: true,
        title: Text('come_in'),
      ),
      body: ListView(children: []),
    );
  }
}
