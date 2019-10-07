import 'package:flutter/material.dart';
import 'camera_page.dart';
import 'events_page.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(controller: controller, children: [
        CameraPage(controller: controller,),
        HomePage(controller: controller,),
        EventPage(controller: controller),
      ]),
    );
  }
}
