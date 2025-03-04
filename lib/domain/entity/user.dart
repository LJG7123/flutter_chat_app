class User {
  final String id;
  final String email;
  final String name;
  final DateTime dob;
  final Gender gender;
  final bool isReceptionAllowed;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.dob,
    required this.gender,
    required this.isReceptionAllowed,
  });
}

enum Gender {
  male('남자'),
  female('여자'),
  undefined('비공개');

  final String label;

  const Gender(this.label);

  factory Gender.fromLabel(String label) {
    return Gender.values.firstWhere(
      (value) => value.label == label,
      orElse: () => Gender.undefined,
    );
  }
}
