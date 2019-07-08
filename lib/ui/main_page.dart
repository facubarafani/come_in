import 'package:flutter/material.dart';

import 'camera_page.dart';
import 'events_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: [
        CameraPage(),
        HomePage(),
        EventPage(),
      ]),
    );
  }
}