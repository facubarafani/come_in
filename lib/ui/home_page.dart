import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final PageController controller;

  HomePage({Key key, this.controller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Widget _buildEventCard() {
  return Column(
    children: [
      Card(
        margin: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Wrap(
            children: [
              Text(
                'Upcoming events',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Divider()
            ],
          ),
        ),
      )
    ],
  );
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            widget.controller.animateToPage(0,duration: Duration(milliseconds: 500),curve:Curves.ease);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              widget.controller.animateToPage(2,duration: Duration(milliseconds: 500),curve:Curves.ease);
            },
          )
        ],
        centerTitle: true,
        title: Text('come_in'),
      ),
      body: ListView(
        children: [
          _buildEventCard(),
        ],
      ),
    );
  }
}
