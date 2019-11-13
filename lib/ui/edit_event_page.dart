import 'package:come_in/bloc/comein_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditEventPage extends StatefulWidget {
  final ComeInEvent event;
  EditEventPage({Key key, this.event}) : super(key: key);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _editTitleController = TextEditingController();
  final _editDescriptionController = TextEditingController();
  final _editLocationController = TextEditingController();
  final _editDateController = TextEditingController();
  var selectedDate = DateTime.now();
  var formatter = DateFormat('yMd');
  void initState() {
    super.initState();
    _editTitleController..text = widget.event.title;
    _editDescriptionController..text = widget.event.description;
    _editLocationController..text = widget.event.location;
    _editDateController..text = formatter.format(DateTime.parse(widget.event.date));
  }

  @override
  Widget build(BuildContext context) {
    ComeInBloc comeInBloc = ComeInProvider.of(context).comeInBloc;
    var selectedDate = DateTime.parse(widget.event.date);
    var formatter = DateFormat('yMd');
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
              var editDate = _editDateController.text;
              print(widget.event.id);
              comeInBloc.editEvent(
                  editTitle, editDescription, editLocation, editDate ,widget.event.id);
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
                Container(
                  padding: EdgeInsets.only(top: 16),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _editTitleController,
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
                    controller: _editDescriptionController,
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
                    controller: _editLocationController,
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
                                MediaQuery.of(context).copyWith().size.height /
                                    3,
                            child: Theme(
                              data: ThemeData.light(),
                              child: CupertinoDatePicker(
                                initialDateTime: selectedDate,
                                onDateTimeChanged: (DateTime newdate) {
                                  selectedDate = newdate;
                                  _editTitleController
                                    ..text = formatter.format(selectedDate);
                                },
                                minimumYear: DateTime.now().year,
                                minimumDate: DateTime.now(),
                                mode: CupertinoDatePickerMode.date,
                              ),
                            ),
                          );
                        });
                  },
                  child: AbsorbPointer(
                    child: Container(
                      padding: EdgeInsets.only(top: 16),
                      child: TextField(
                        controller: _editDateController,
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
        )
      ]),
    );
  }
}
