class ComeInEvent {
  String title;
  String description;
  String location;

  ComeInEvent({this.title, this.description, this.location});

  factory ComeInEvent.fromJson(json) {
    return ComeInEvent(
      title: json['title'],
      description: json['description'],
      location: json['location'],
    );
  }
}
