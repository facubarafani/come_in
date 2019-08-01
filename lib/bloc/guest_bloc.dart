import 'package:come_in/models/guest.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:rxdart/rxdart.dart';

class GuestBloc {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final _subject = BehaviorSubject<List<Guest>>();
  final _subjectIsLoading = BehaviorSubject<bool>();
  Stream<List<Guest>> get guests => _subject.stream;
  Stream<bool> get isLoading => _subjectIsLoading.stream;

  GuestBloc(){
    _subjectIsLoading.sink.add(true);
  }

  Future createGuest(firstName, lastName, String id) async {
    _database.child('events').child(id).child('guests').push().set({
      'firstName': firstName,
      'lastName': lastName,
    });
  }

  Future getGuest(String id) async {
    _database.child('events').child(id).child('guests').once().then((snapshot) {
      List<Guest> list = [];
      if (snapshot.value != null) {
        snapshot.value.forEach((key, value) => list.add(Guest.fromJson(value)));
        _subjectIsLoading.sink.add(null);
        _subject.sink.add(list);
      } else {
        _subjectIsLoading.sink.add(null);
        _subject.sink.add(null);
      }
    });
  }

  Future removeGuest(String eventId, String guestId) async {
    _database
        .child('events')
        .child(eventId)
        .child('guests')
        .child(guestId)
        .remove();
  }

  dispose() {
    _subject.close();
    _subjectIsLoading.close();
    this.dispose();
  }
}
