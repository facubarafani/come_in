import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Widget _buildUserCard() {
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
                'User will appear here',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider()
            ],
          ),
        ),
      )
    ],
  );
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
            children: [Text('Upcoming events'), Divider()],
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
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          )
        ],
        centerTitle: true,
        title: Text('come_in'),
      ),
      body: ListView(children: [_buildUserCard(), _buildEventCard()]),
    );
  }
}
