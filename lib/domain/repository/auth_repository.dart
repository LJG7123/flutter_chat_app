abstract interface class AuthRepository {
  Future<String?> signIn(String email, String password);

  String? getCurrentUser();
}