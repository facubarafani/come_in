class Guest {
  var id;
  var firstName;
  var lastName;
  var hasEntered;
  var entryAt;

  Guest({
    this.id,
    this.firstName,
    this.lastName,
    this.hasEntered,
    this.entryAt,
  });

  factory Guest.fromJson(json) {
    return Guest(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      hasEntered: json['hasEntered'],
      entryAt: json['entryAt'],
    );
  }
}
