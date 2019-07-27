import 'package:come_in/models/guest.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share/share.dart';

class GuestDetailPage extends StatefulWidget {
  final Guest guest;
  GuestDetailPage({Key key, this.guest}) : super(key: key);
  @override
  _GuestDetailPageState createState() => _GuestDetailPageState();
}

class _GuestDetailPageState extends State<GuestDetailPage> {
  @override
  Widget _builGuestDetail() {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First Name',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.guest.firstName,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Last Name',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Text(
                  widget.guest.lastName,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    var guestFullName = widget.guest.firstName + ' ' + widget.guest.lastName;
    return Scaffold(
      appBar: AppBar(
        title: Text(guestFullName),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            _builGuestDetail(),
            SizedBox(
              height: 220,
            ),
            GestureDetector(
              onTap: () {
                
              },
              child: QrImage(
                data: widget.guest.id,
                size: 200,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
