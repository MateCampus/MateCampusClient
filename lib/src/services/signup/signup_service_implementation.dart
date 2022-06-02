import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/object/firebase_object.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';
import 'package:http/http.dart' as http;

class SignUpServiceImpl implements SignUpService {
  @override
  Future<bool> checkIdRedundancy({required String id}) async {
    // TODO: implement checkIdRedundancy
    bool value = true;
    return value;
  }

  @override
  Future<bool> checkNicknameRedundancy({required String nickname}) async {
    // TODO: implement checkNicknameRedundancy
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
    var request =
        http.MultipartRequest("POST", Uri.parse(devServer + "/api/signup"));

    request.fields['loginId'] = id;
    request.fields['password'] = pw;
    request.fields['nickname'] = nickname;
    request.fields['deviceToken'] =
        FirebaseObject.deviceFcmToken ?? "fake token";
    request.fields['collegeCode'] = collegeCode;
    request.fields['majorCode'] = majorCode;
    request.files.add(await http.MultipartFile.fromPath(
        'studentIdImg', studentIdImg.path)); //그러면 결국 XFile로 가져올 필요가 없지 않나?

    //리스트 넘기는 법
    String interestCodesJson = "";
    interestCodes.forEach((interestCode) {
      interestCodesJson = interestCodesJson + interestCode + ",";
    });
    interestCodesJson =
        interestCodesJson.substring(0, interestCodesJson.length - 1);
    request.fields["interestCodes"] = interestCodesJson;

    if (profileImg != null) {
      request.files.add(
          await http.MultipartFile.fromPath('profileImg', profileImg.path));
    }

    if (introduce != null) {
      request.fields['introduce'] = introduce;
    }

    var response = await request.send();
    if (response.statusCode == 201) {
      print('회원가입 성공');
      return true;
    } else {
      return false;
      throw Exception("회원가입 오류");
    }
  }
}
