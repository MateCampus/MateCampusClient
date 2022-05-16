abstract class SignUpService {
  Future<bool> checkIdRedundancy({required String id});
  Future<bool> checkNicknameRedundancy({required String nickname});
}
