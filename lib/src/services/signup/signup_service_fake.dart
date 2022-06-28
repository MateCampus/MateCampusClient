import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';

class FakeSignUpService implements SignUpService {
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

  @override
  Future<bool> createUser(
      {required String id,
      required String pw,
      required String collegeCode,
      required String majorCode,
      required XFile studentIdImg,
      required String nickname,
      required List<String> interestCodes,
      XFile? profileImg,
      String? introduce}) async {
    return true;
  }

  @override
  Future<bool> requestMajor({required String body}) async {
    return true;
  }
}
