class AuthService {
  String? _userId;

  bool get isLoggedIn => _userId != null;

  String? get userId => _userId;

  Future<bool> login({required String email, required String password}) async {
    // Mock login
    await Future.delayed(const Duration(milliseconds: 400));
    _userId = 'user_123';
    return true;
  }

  Future<void> logout() async {
    _userId = null;
  }

  Future<bool> signup({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    _userId = 'user_123';
    return true;
  }
}
