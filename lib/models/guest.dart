class Guest {
  var firstName;
  var lastName;

  Guest({
    this.firstName,
    this.lastName,
  });

  factory Guest.fromJson(json) {
    return Guest(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
