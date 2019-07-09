import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

Widget _buildEventCard() {
  return Column(
    children: [
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(15),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Wrap(
            children: [
              Text(
                'Event name will appear here',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Divider(),
              Text('Event description will appear here'),
              Divider(),
              Row(
                children: [
                  Icon(Icons.location_on),
                  Text('Event location will appear here'),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Icon(Icons.calendar_today),
                  Text('Event date will appear here'),
                ],
              )
            ],
          ),
        ),
      )
    ],
  );
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
          onPressed: () {},
        ),
      ),
      body: ListView(children: [_buildEventCard()]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/createevent');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
