import 'package:come_in/bloc/comein_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:flutter/material.dart';

class EditEventPage extends StatefulWidget {
  final ComeInEvent event;
  EditEventPage({Key key, this.event}) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  @override
  Widget build(BuildContext context) {
    ComeInBloc comeInBloc = ComeInProvider.of(context).comeInBloc;
    TextEditingController _editTitleController =
        TextEditingController(text: widget.event.title);
    TextEditingController _editDescriptionController =
        TextEditingController(text: widget.event.description);
    TextEditingController _editLocationController =
        TextEditingController(text: widget.event.location);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Modify Event'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              var editTitle = _editTitleController.text;
              var editDescription = _editDescriptionController.text;
              var editLocation = _editLocationController.text;
              comeInBloc.editEvent(editTitle, editDescription, editLocation);
            },
          )
        ],
      ),
      body: ListView(children: [
        Form(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  controller: _editTitleController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.event), labelText: 'Event name'),
                ),
                TextFormField(
                  controller: _editDescriptionController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.description),
                      labelText: 'Event Description'),
                ),
                TextFormField(
                  controller: _editLocationController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.my_location),
                      labelText: 'Event Location'),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
