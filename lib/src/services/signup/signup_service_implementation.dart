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
    ///서버에서 받아오는 값은
    ///중복일때 true
    ///중복이 아니면 false
    ///그런데 이걸 뷰모델에 전달해줄때는 isValidId 변수에 전달하기 때문에
    ///서버에서 받아온 값을 반대로 줘야함. 그걸 여기서 하냐 뷰모델에서 하냐 차이인데
    ///일단 여기서 반대로 주자

    bool isDuplicated = false;
    final response = await http
        .get(Uri.parse(devServer + "/api/signup/id/duplication/" + id));
    if (response.statusCode == 200) {
      if (response.body == "false") {
        //아이디 중복 안됨! 써도 됨!
        isDuplicated = true;
      } else if (response.body == "true") {
        //아이디 중복
        isDuplicated = false;
      }
    } else {
      throw Exception('닉네임 중복 검사 서버 오류');
    }
    // bool value = true;
    return isDuplicated;
  }

  @override
  Future<bool> checkNicknameRedundancy({required String nickname}) async {
    bool isDuplicated = false;
    final response = await http.get(
        Uri.parse(devServer + "/api/signup/nickname/duplication/" + nickname));
    if (response.statusCode == 200) {
      if (response.body == "false") {
        //닉네임 중복 안됨! 써도 됨!
        isDuplicated = true;
      } else if (response.body == "true") {
        //닉네임 중복
        isDuplicated = false;
      }
    } else {
      throw Exception('닉네임 중복 검사 서버 오류');
    }
    // bool value = true;
    return isDuplicated;
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
    // TODO: 바꿔야할지도? join으로
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

  @override
  Future<bool> requestMajor({required String body}) async {
    String bodyJson = jsonEncode({"body": body});

    final response = await http
        .post(Uri.parse(devServer + "/api/signup/request"), body: bodyJson);

    if (response.statusCode == 201) {
      print('학과 요청 성공');
      return true;
    } else {
      print('요청 실패');
      // return false;
      return true;
    }
  }
}
