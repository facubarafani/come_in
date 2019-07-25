import 'guest.dart';

class ComeInEvent {
  var id;
  String title;
  String description;
  String location;
  // List<Guest> guests;

  ComeInEvent({this.title, this.description, this.location});

  factory ComeInEvent.fromJson(json) {
    // List<Guest> list = [];
    // for (final i in json['guests']) {
    //   Guest guest = Guest.fromJson(i);
    //   list.add(guest);
    // }

    return ComeInEvent(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      // guests: list,
    );
  }
}
