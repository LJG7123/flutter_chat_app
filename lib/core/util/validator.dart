class Validator {
  static final emailRegex = RegExp(
      r'^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$');
  static final passwordRegex = RegExp(
      r'^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{6,}$');

  static bool isEmailValid(String email) {
    return emailRegex.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return passwordRegex.hasMatch(password);
  }

  static bool isDoBValid(String dob) {
    final date = DateTime.tryParse(dob);

    if (date == null) return false;
    return date.isBefore(DateTime.now()) && date.isAfter(DateTime(1900));
  }
}
