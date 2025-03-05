class User {
  final String id;
  final String email;
  final String name;
  final DateTime dob;
  final Gender gender;
  final bool isReceptionAllowed;
  final String? imageUrl;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.dob,
    required this.gender,
    required this.isReceptionAllowed,
    this.imageUrl,
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? dob,
    Gender? gender,
    bool? isReceptionAllowed,
    String? imageUrl,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      isReceptionAllowed: isReceptionAllowed ?? this.isReceptionAllowed,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
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
