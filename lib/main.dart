import 'package:come_in/providers/comein_provider.dart';
import 'package:come_in/ui/add_guest_page.dart';
import 'package:come_in/ui/camera_page.dart';
import 'package:come_in/ui/create_event_page.dart';
import 'package:come_in/ui/edit_event_page.dart';
import 'package:come_in/ui/events_page.dart';
import 'package:come_in/ui/home_page.dart';
import 'package:come_in/ui/main_page.dart';
import 'package:flutter/material.dart';
import 'bloc/comein_bloc.dart';
import 'bloc/guest_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComeInProvider(
      comeInBloc: ComeInBloc(),
      guestBloc: GuestBloc(),
      child: MaterialApp(
        title: 'come_in',
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: MainPage(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomePage(),
          '/camera': (BuildContext context) => CameraPage(),
          '/events': (BuildContext context) => EventPage(),
          '/main': (BuildContext context) => MainPage(),
          '/createevent': (BuildContext context) => CreateEventPage(),
          '/editevent': (BuildContext context) => EditEventPage(),
          '/addguest': (BuildContext context) => AddGuestPage(),
        },
      ),
    );
  }
}
