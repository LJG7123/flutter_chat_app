class User {
  final String id;
  final String email;
  final String name;
  final int age;
  final Gender gender;
  final bool isReceptionAllowed;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.age,
    required this.gender,
    required this.isReceptionAllowed,
  });
}

enum Gender {
  male('male'),
  female('female'),
  undefined('undefined');

  final String label;

  const Gender(this.label);

  factory Gender.fromLabel(String label) {
    return Gender.values.firstWhere(
      (value) => value.label == label,
      orElse: () => Gender.undefined,
    );
  }
}
