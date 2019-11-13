import 'package:come_in/bloc/comein_bloc.dart';
import 'package:come_in/bloc/guest_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/models/guest.dart';
import 'package:flutter/cupertino.dart';
import 'guest_detail_page.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'add_guest_page.dart';
import 'edit_event_page.dart';
import 'package:intl/intl.dart';

class EventDetailPage extends StatefulWidget {
  final ComeInEvent event;
  EventDetailPage({Key key, this.event}) : super(key: key);
  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  
  var formatter = DateFormat('yMd');
  @override
  void initState() {
    super.initState();
    final DatabaseReference _database = FirebaseDatabase.instance.reference();
    _database
        .child('events')
        .child(widget.event.id)
        .child('guests')
        .onChildAdded
        .listen((snapshot) {
      _database
          .child('events')
          .child(widget.event.id)
          .child('guests')
          .child(snapshot.snapshot.key)
          .update({
        'id': snapshot.snapshot.key,
      });
    });
  }

  Widget _buildEventDetail() {
    var _eventDate = DateTime.parse(widget.event.date);
    var formattedDate = formatter.format(_eventDate);
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
                  '${widget.event.location}',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Event Date',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  formattedDate,
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Text('Attended'),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 20,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Text('No attendance'),
                    ),
                  ],
                )
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  _buildHasEnteredIcon(Guest data) {
    if (data.hasEntered == true) {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
      );
    } else {
      return Icon(
        Icons.cancel,
        color: Colors.red,
      );
    }
  }

  _buildGuest(List data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Guest guests = data[index];
        return Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GuestDetailPage(
                    guest: data[index],
                    event: widget.event,
                  ),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 6,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          guests.firstName,
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          guests.lastName,
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        _buildHasEnteredIcon(guests)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    GuestBloc guestBloc = ComeInProvider.of(context).guestBloc;
    guestBloc.getGuest(widget.event.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              ComeInBloc comeInBloc = ComeInProvider.of(context).comeInBloc;
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            child: Text(
                              'Delete Event',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              comeInBloc.removeEvent(widget.event.id);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text(
                            'Cancel',
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'One');
                          },
                        ),
                      ));
            },
          )
        ],
      ),
      body: Container(
          child: Column(
        children: [
          _buildEventDetail(),
          _buildGuestList(),
          Expanded(
            flex: 2,
            child: StreamBuilder(
              stream: guestBloc.guests,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? _buildGuest(snapshot.data)
                    : StreamBuilder(
                        stream: guestBloc.isLoading,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return (snapshot.hasData)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Center(child: Text('No guests added yet'));
                        },
                      );
              },
            ),
          ),
        ],
      )),
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
