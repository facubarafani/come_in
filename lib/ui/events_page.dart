import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Events'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
          },
        ),
      ),
      body: ListView(children: []),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/createevent');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
