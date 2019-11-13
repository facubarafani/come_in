class ComeInEvent {
  var id;
  String title;
  String description;
  String location;
  var date;

  ComeInEvent({this.id, this.title, this.description, this.location,this.date});

  factory ComeInEvent.fromJson(json) {
    return ComeInEvent(
      title: json['title'],
      description: json['description'],
      location: json['location'],
      id: json['id'],
      date: json['date'],
    );
  }
}
