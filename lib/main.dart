import 'package:come_in/providers/comein_provider.dart';
import 'package:come_in/ui/camera_page.dart';
import 'package:come_in/ui/events_page.dart';
import 'package:come_in/ui/home_page.dart';
import 'package:come_in/ui/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComeInProvider(
      child: MaterialApp(
        title: 'come_in',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: LoginPage(),
        routes: <String, WidgetBuilder>{
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => HomePage(),
          '/camera': (BuildContext context) => CameraPage(),
          '/events': (BuildContext context) => EventPage(),
        },
      ),
    );
  }
}
