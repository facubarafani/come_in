class Guest {
  var id;
  var firstName;
  var lastName;

  Guest({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory Guest.fromJson(json) {
    return Guest(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
