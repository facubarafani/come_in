import 'package:come_in/bloc/comein_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:flutter/material.dart';
import 'event_qr_page.dart';
import 'package:intl/intl.dart' as intl;

class CameraPage extends StatefulWidget {
  final PageController controller;

  CameraPage({Key key, this.controller}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
    var formatter = intl.DateFormat('yMd');
  Widget _buildEventList(List<ComeInEvent> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        ComeInEvent events = list[index];
        var _eventDate = DateTime.parse(events.date);
        var formattedDate = formatter.format(_eventDate);
        return Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EventQRPage(
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
                        Text('$formattedDate'),
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

  Widget build(BuildContext context) {
    ComeInBloc comeInBloc = ComeInProvider.of(context).comeInBloc;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('QR Scanner'),
        actions: [
          IconButton(
            onPressed: () {
              widget.controller.animateToPage(1,
                  duration: Duration(milliseconds: 500), curve: Curves.ease);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              textDirection: TextDirection.rtl,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Select an event to scan QRs',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: comeInBloc.events,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? _buildEventList(snapshot.data)
                    : Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
