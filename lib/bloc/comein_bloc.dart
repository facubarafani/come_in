import 'package:come_in/models/event.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class ComeInBloc {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final _subject = BehaviorSubject<List<ComeInEvent>>();
  Stream<List<ComeInEvent>> get events => _subject.stream;

  ComeInBloc() {
    getEvents();
  }

  Future createEvent(title, description, location) async {
    _database.child('events').push().set(
      {
        'title': title,
        'description': description,
        'location': location,
      },
    );
  }
  Future testGetKey() async {
    _database.child('events').onChildAdded.listen((snapshot){
      print(snapshot.snapshot.key);
    });
  }

  Future getEvents() async {
    _database.child('events').once().then((snapshot) {
      List<ComeInEvent> list = [];
      snapshot.value
          .forEach((key, value) => list.add(ComeInEvent.fromJson(value)));
      _subject.sink.add(list);
    });
  }

  Future editEvent(title, description, location, String id) async {
    _database.child('events').child(id).update({
      'title': title,
      'description': description,
      'location': location,
    });
  }

  dispose() {
    _subject.close();
    this.dispose();
  }
}
