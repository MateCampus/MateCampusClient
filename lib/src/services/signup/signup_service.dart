import 'package:image_picker/image_picker.dart';

abstract class SignUpService {
  Future<bool> checkIdRedundancy({required String id});
  Future<bool> checkNicknameRedundancy({required String nickname});
  Future<bool> createUser(
      {required String id,
      required String pw,
      required String collegeCode,
      required String majorCode,
      required XFile studentIdImg,
      required String nickname,
      required List<String> interestCodes,
      XFile? profileImg,
      String? introduce});
}
