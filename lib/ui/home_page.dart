import 'package:come_in/bloc/comein_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final PageController controller;

  HomePage({Key key, this.controller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

Widget _buildEventList(List<ComeInEvent> list) {
  return SizedBox(
    height: 1000,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          ComeInEvent events = list[index];
          var _eventDate = DateTime.parse(events.date);
          var _today = DateTime.now();
          final difference = _eventDate.difference(_today).inDays;
          return (difference <= 7 && difference >= 0)
              ? _buildUpcomingEvent(events, difference)
              : Container();
        },
    ),
  );
}

Widget _buildEventCard(context) {
  ComeInBloc comeInBloc = ComeInProvider.of(context).comeInBloc;
  return Padding(
    padding: EdgeInsets.all(12),
      child: Column(
      children: [
                Text(
                  'Upcoming events',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Divider(),
                StreamBuilder(
                  stream: comeInBloc.events,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasData
                        ? _buildEventList(snapshot.data)
                        : Center(child: CircularProgressIndicator());
                  },
                ),
              ],
    ),
  );
}

Widget _buildUpcomingEvent(ComeInEvent event, difference) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(
            event.title,
            style: TextStyle(fontSize: 18),
          ),
          Spacer(),
          _buildDaysLeftChip(difference),
        ],
      ),
      Column(
        children: [
          Text(
            'Description: ${event.description}',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
      Divider(),
    ],
  );
}

Widget _buildDaysLeftChip(difference) {
  return (difference != 0)
          ? Chip(
          backgroundColor: Colors.grey,
          label: Text('Days left: $difference'),
        )
        : Chip(
          backgroundColor: Colors.blue,
          label: Text('Today'),
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
            widget.controller.animateToPage(0,
                duration: Duration(milliseconds: 500), curve: Curves.ease);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {
              widget.controller.animateToPage(2,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
          )
        ],
        centerTitle: true,
        title: Text('come_in'),
      ),
      body: ListView(
        children: [
          _buildEventCard(context),
        ],
      ),
    );
  }
}
