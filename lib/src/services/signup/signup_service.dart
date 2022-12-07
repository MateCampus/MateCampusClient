import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/major.dart';

abstract class SignUpService {
  Future<bool> checkIdRedundancy({required String id});
  Future<bool> checkNicknameRedundancy({required String nickname});
  Future<List<Major>> fetchMajors({ required String searchText});
  Future<bool> createUser(
      {required String id,
      required String pw,
      required String collegeCode,
      required String mClass,
      required String majorSeq,
      required XFile studentIdImg,
      required String nickname,
      required String grade,
      required String gender,
      required String birth,
      required List<String> interestCodes,
      XFile? profileImg,
      String? introduce});
  Future<bool> requestMajor({required String body});
}
