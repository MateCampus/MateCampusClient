abstract class LoginService {
  Future<bool> login({required String id, required String password});
  Future<void> reissueToken();
}
