import 'package:come_in/models/event.dart';
import 'package:flutter/material.dart';

import 'add_guest_page.dart';
import 'edit_event_page.dart';

class EventDetailPage extends StatefulWidget {
  final ComeInEvent event;
  EventDetailPage({Key key, this.event}) : super(key: key);
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget _buildEventDetail() {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Name',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.event.title,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Description',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.event.description,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Location',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.event.location,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestList() {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Guests',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 260,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AddGuestPage(
                              event: widget.event,
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.add),
                    )
                  ],
                ),
              ],
            ),
            Divider(),
            Text(
              'No guests invited yet',
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        children: [_buildEventDetail(), _buildGuestList()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditEventPage(
                event: widget.event,
              ),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
