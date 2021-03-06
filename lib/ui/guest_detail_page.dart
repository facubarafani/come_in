import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:come_in/bloc/guest_bloc.dart';
import 'package:come_in/models/event.dart';
import 'package:come_in/models/guest.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:intl/intl.dart';

class GuestDetailPage extends StatefulWidget {
  final Guest guest;
  final ComeInEvent event;
  GuestDetailPage({Key key, this.guest, this.event}) : super(key: key);
  @override
  _GuestDetailPageState createState() => _GuestDetailPageState();
}

class _GuestDetailPageState extends State<GuestDetailPage> {
  final GlobalKey _renderObjectKey = new GlobalKey();
  var formatter = DateFormat('yMd');
  var timeFormatter = DateFormat('Hms');

  Future<void> _getQRCodeImage() async {
    try {
      RenderRepaintBoundary boundary =
          _renderObjectKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      debugPrint(bs64.length.toString());
      Share.file('Share QR Code', 'qr_code.png', pngBytes.buffer.asUint8List(),
          'image/png',
          text:
              'You were invited to my event! The following QR code will provide you access to the event.');
    } catch (exception) {}
  }

  Widget _buildEntryAt(Guest guest) {
    return (guest.entryAt != 'no_entry')
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Entry at',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              Text(
                '${formatter.format(DateTime.parse(guest.entryAt))} a las ${timeFormatter.format(DateTime.parse(guest.entryAt))}',
                style: TextStyle(fontSize: 20),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Entry at',
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              Text(
                'Guest has not entered yet',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          );
  }

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
            Divider(),
            Container(
              child: _buildEntryAt(widget.guest),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButton() {
    return FloatingActionButton(
      onPressed: () {
        _getQRCodeImage();
      },
      child: Icon(Icons.share),
      tooltip: 'Share QR code',
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
            onPressed: () {
              GuestBloc guestBloc = ComeInProvider.of(context).guestBloc;
              showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            child: Text(
                              'Delete Guest',
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              guestBloc.removeGuest(
                                  widget.event.id, widget.guest.id);
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: Text(
                            'Cancel',
                          ),
                          onPressed: () {
                            Navigator.pop(context, 'One');
                          },
                        ),
                      ));
            },
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            Column(
              children: [
                _builGuestDetail(),
                SizedBox(
                  height: 220,
                ),
                GestureDetector(
                  onTap: () {
                    _getQRCodeImage();
                  },
                  child: RepaintBoundary(
                    key: _renderObjectKey,
                    child: QrImage(
                      data: widget.guest.id,
                      size: 200,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 580,
              left: 280,
              child: _buildShareButton(),
            )
          ],
        ),
      ),
    );
  }
}
