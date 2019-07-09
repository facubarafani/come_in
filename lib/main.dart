import 'package:camera/camera.dart';
import 'package:come_in/providers/comein_provider.dart';
import 'package:come_in/ui/camera_page.dart';
import 'package:come_in/ui/create_event_page.dart';
import 'package:come_in/ui/edit_event_page.dart';
import 'package:come_in/ui/events_page.dart';
import 'package:come_in/ui/home_page.dart';
import 'package:come_in/ui/login_page.dart';
import 'package:come_in/ui/main_page.dart';
import 'package:flutter/material.dart';

import 'bloc/comein_bloc.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComeInProvider(
      comeInBloc: ComeInBloc(),
      child: MaterialApp(
        title: 'come_in',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: LoginPage(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => HomePage(),
          '/camera': (BuildContext context) => CameraPage(cameras),
          '/events': (BuildContext context) => EventPage(),
          '/main': (BuildContext context) => MainPage(cameras),
          '/createevent': (BuildContext context) => CreateEventPage(),
          '/editevent': (BuildContext context) => EditEventPage(),
        },
      ),
    );
  }
}
