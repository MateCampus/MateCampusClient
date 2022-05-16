import 'package:zamongcampus/src/services/signup/signup_service.dart';

class SignUpServiceFake implements SignUpService {
  @override
  Future<bool> checkIdRedundancy({required String id}) async {
    bool value = true;
    return value;
  }

  @override
  Future<bool> checkNicknameRedundancy({required String nickname}) async {
    bool value = true;
    return value;
  }
}
