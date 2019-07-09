import 'package:come_in/bloc/comein_bloc.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  Widget _buildEventForm() {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                  icon: Icon(Icons.event), labelText: 'Event name'),
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  labelText: 'Event Description'),
            ),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                  icon: Icon(Icons.my_location), labelText: 'Event Location'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ComeInBloc comeInBloc = ComeInProvider.of(context).comeInBloc;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Event'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              var title = _titleController.text;
              var description = _descriptionController.text;
              var location = _locationController.text;
              comeInBloc.createEvent(title, description, location);
            },
          )
        ],
      ),
      body: ListView(children: [_buildEventForm()]),
    );
  }
}
