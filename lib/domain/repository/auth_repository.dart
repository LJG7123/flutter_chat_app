abstract interface class AuthRepository {
  Future<String?> signIn(String email, String password);

  Future<void> signOut();

  String? getCurrentUser();
}