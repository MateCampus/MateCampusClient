import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';
import 'package:http/http.dart' as http;

class SignUpServiceImpl implements SignUpService {
  @override
  Future<bool> checkIdRedundancy({required String id}) async {
    // TODO: implement checkIdRedundancy
    throw UnimplementedError();
  }

  @override
  Future<bool> checkNicknameRedundancy({required String nickname}) async {
    // TODO: implement checkNicknameRedundancy
    throw UnimplementedError();
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
    var request =
        http.MultipartRequest("SIGNUP", Uri.parse(devServer + "api/signup"))
          ..headers.addAll(AuthService.get_auth_header());

    request.fields['id'] = id;
    request.fields['pw'] = pw;
    request.fields['collegeCode'] = collegeCode;
    request.fields['majorCode'] = majorCode;
    request.files.add(await http.MultipartFile.fromPath(
        'studentIdImg', studentIdImg.path)); //그러면 결국 XFile로 가져올 필요가 없지 않나?
    request.fields['nickname'] = nickname;

    //리스트 넘기는 법
    for (String interestCode in interestCodes) {
      request.files
          .add(http.MultipartFile.fromString('interestList', interestCode));
    }

    if (profileImg != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profileImg', profileImg.path));
    }
    if (introduce != null) {
      request.fields['introduce'] = introduce;
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      print('회원가입 성공');
      return true;
    } else {
      return false;
      throw Exception("회원가입 오류");
    }
  }
}
