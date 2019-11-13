import 'package:come_in/bloc/guest_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddGuestPage extends StatefulWidget {
  @override
  final ComeInEvent event;
  AddGuestPage({Key key, this.event}) : super(key: key);
  _AddGuestPageState createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  Widget _buildEventForm() {
    return Form(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'First Name',
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(Icons.person),
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
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Event Title',
                  contentPadding: EdgeInsets.all(8),
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
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
    GuestBloc guestBloc = ComeInProvider.of(context).guestBloc;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('New Guest'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              var firstName = _firstNameController.text;
              var lastName = _lastNameController.text;
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CupertinoAlertDialog(
                    title: Text('Confirm guest creation'),
                    content:
                        Text('Are you sure you want to create this guest?'),
                    actions: [
                      CupertinoButton(
                        onPressed: () {
                          guestBloc.createGuest(firstName, lastName, widget.event.id);
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
