import 'package:come_in/bloc/comein_bloc.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  var selectedDate;

  Widget _buildEventForm() {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Event Title',
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _descriptionController,
                decoration: InputDecoration(
                  hintText: 'Event Description',
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 16),
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Event Location',
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(Icons.my_location),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext builder) {
                      return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 3,
                        child: Theme(
                          data: ThemeData.light(),
                          child: CupertinoDatePicker(
                            initialDateTime: DateTime.now(),
                            onDateTimeChanged: (DateTime newdate) {
                              selectedDate = newdate;
                              _dateController..text = selectedDate.toString();
                            },
                            use24hFormat: true,
                            minimumYear: DateTime.now().year,
                            minuteInterval: 1,
                            mode: CupertinoDatePickerMode.dateAndTime,
                          ),
                        ),
                      );
                    });
              },
              child: AbsorbPointer(
                child: Container(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Event Date',
                      contentPadding: EdgeInsets.all(8),
                      prefixIcon: Icon(Icons.event),
                      border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                    ),
                  ),
                ),
              ),
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
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  var title = _titleController.text;
                  var description = _descriptionController.text;
                  var location = _locationController.text;
                  return CupertinoAlertDialog(
                    title: Text('Confirm event creation'),
                    content:
                        Text('Are you sure you want to create this event?'),
                    actions: [
                      CupertinoButton(
                        onPressed: () {
                          comeInBloc.createEvent(title, description, location);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text('Accept'),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
      body: ListView(children: [_buildEventForm()]),
    );
  }
}
