import 'package:come_in/models/guest.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class GuestBloc {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final _subject = BehaviorSubject<List<Guest>>();
  Stream<List<Guest>> get guests => _subject.stream;

  Future createGuest(firstName, lastName, String id) async {
    _database.child('events').child(id).child('guests').push().set({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future getGuest(String id) async {
    _database.child('events').child(id).child('guests').once().then((snapshot) {
      List<Guest> list = [];
      snapshot.value.forEach((key, value) => list.add(Guest.fromJson(value)));
      _subject.sink.add(list);
    });
  }

  dispose() {
    _subject.close();
    this.dispose();
  }
}