class Vet {
  final String firstName;
  final String lastName;

  Vet({
    required this.firstName,
    required this.lastName,
  });

  String get fullName => '$firstName $lastName';
}
