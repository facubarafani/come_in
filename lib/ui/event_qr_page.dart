import 'package:barcode_scan/barcode_scan.dart';
import 'package:come_in/bloc/guest_bloc.dart';
import 'dart:convert' as JSON;
import 'package:come_in/models/event.dart';
import 'package:come_in/models/guest.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:come_in/ui/guest_detail_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventQRPage extends StatefulWidget {
  @override
  final ComeInEvent event;
  EventQRPage({Key key, this.event}) : super(key: key);
  _EventQRPageState createState() => _EventQRPageState();
}

class _EventQRPageState extends State<EventQRPage> {
  @override
  var _cardColor;
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  String result = "";
  Future _scanQR() async {
    var _key = widget.event.id;
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        _database
            .child('events')
            .child(_key)
            .child('guests')
            .child(qrResult)
            .once()
            .then((snapshot) {
          if (snapshot.value == null) {
            result = ('The QR code is invalid');
            _cardColor = Colors.red;
          } else {
            Guest guest = Guest.fromJson(snapshot.value);
            result = ('QR code validated successfully ${guest.firstName}' +
                ' ' +
                '${guest.lastName}');
            _cardColor = Colors.green;
            _database
                .child('events')
                .child(_key)
                .child('guests')
                .child(qrResult)
                .update({
              'hasEntered': true,
            });
            _database
                .child('events')
                .child(_key)
                .child('guests')
                .child(qrResult)
                .update({
              'entryAt': DateTime.now(),
            });
          }
        });
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  Widget _buildValidationCard() {
    return result != ''
        ? Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: _cardColor,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                result,
                textAlign: TextAlign.center,
                style:
                    new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
          )
        : Text('');
  }

  _buildGuest(List data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        Guest guests = data[index];
        return (guests.hasEntered == true)
        ? Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GuestDetailPage(
                    guest: data[index],
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
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        : Container();
      },
    );
  }

  Widget build(BuildContext context) {
    GuestBloc guestBloc = ComeInProvider.of(context).guestBloc;
    guestBloc.getGuest(widget.event.id);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.event.title),
      ),
      body: Column(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Text(
              'Attendants',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: StreamBuilder(
            stream: guestBloc.guests,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? _buildGuest(snapshot.data)
                  : StreamBuilder(
                      stream: guestBloc.isLoading,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
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
        Center(
          child: _buildValidationCard(),
        ),
      ]),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
