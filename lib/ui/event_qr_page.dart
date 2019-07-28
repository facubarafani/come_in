import 'package:barcode_scan/barcode_scan.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/models/guest.dart';
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
            result = ('QR code validated successfully');
            _cardColor = Colors.green;
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: _cardColor,
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          result,
          textAlign: TextAlign.center,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
    )
    : Text('');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.event.title),
      ),
      body: Center(child: _buildValidationCard()),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
