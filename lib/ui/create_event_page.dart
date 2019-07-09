import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

Widget _buildEventForm() {
  return Form(
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                icon: Icon(Icons.event), labelText: 'Event name'),
          ),
          TextFormField(
            decoration: InputDecoration(icon: Icon(Icons.description),labelText: 'Event Description'),
          ),
          TextFormField(decoration: InputDecoration(icon: Icon(Icons.my_location),labelText: 'Event Location'),),
        ],
      ),
    ),
  );
}

class _CreateEventPageState extends State<CreateEventPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Event'),
      ),
      body: ListView(children: [_buildEventForm()]),
    );
  }
}
