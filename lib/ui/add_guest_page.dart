import 'package:come_in/bloc/guest_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/providers/comein_provider.dart';
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
            TextFormField(
              controller: _firstNameController,
              decoration: InputDecoration(
                  icon: Icon(Icons.event), labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: InputDecoration(
                  icon: Icon(Icons.description), labelText: 'Last Name'),
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
              guestBloc.createGuest(firstName, lastName, widget.event.id);
            },
          )
        ],
      ),
      body: ListView(children: [_buildEventForm()]),
    );
  }
}
