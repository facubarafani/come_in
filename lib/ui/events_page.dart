import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:come_in/bloc/comein_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'event_detail_page.dart';

class EventPage extends StatefulWidget {
  final PageController controller;

  EventPage({Key key, this.controller}) : super(key: key);

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  void initState() {
    super.initState();
    final DatabaseReference _database = FirebaseDatabase.instance.reference();
    _database.child('events').onChildAdded.listen((snapshot) {
      _database.child('events').child(snapshot.snapshot.key).update({
        'id': snapshot.snapshot.key,
      });
    });
  }

  Widget _buildEventList(List<ComeInEvent> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        ComeInEvent events = list[index];
        return Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventDetailPage(
                    event: list[index],
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Wrap(
                  children: [
                    Text(
                      '${events.title}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Divider(),
                    Text('${events.description}'),
                    Divider(),
                    Row(
                      children: [
                        Icon(Icons.location_on),
                        Text('${events.location}'),
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
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ComeInBloc comeInBloc = ComeInProvider.of(context).comeInBloc;
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Events'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            widget.controller.animateToPage(1,duration: Duration(milliseconds: 500),curve:Curves.ease);
          },
        ),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: comeInBloc.getEvents,
        child: StreamBuilder(
          stream: comeInBloc.events,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? _buildEventList(snapshot.data)
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create an event',
        onPressed: () {
          Navigator.of(context).pushNamed('/createevent');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
