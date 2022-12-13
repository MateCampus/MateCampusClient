import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/major.dart';
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
  //이거는 내정보 수정하기에서도 쓰긴하는데 어차피 헤더에 아무것도 안넣고 보내기때문에 굳이 401로직이 필요없을것같음
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
      required String mClass,
      required String majorSeq,
      required XFile studentIdImg,
      required String nickname,
      required String grade,
      required String gender,
      required String birth,
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
    request.fields['mClass'] = mClass;
    request.fields['majorSeq'] = majorSeq;
    request.fields['grade'] = grade;
    request.fields['gender'] = gender;
    request.fields['birth'] = birth;
    request.files.add(await http.MultipartFile.fromPath(
        'studentIdImg', studentIdImg.path)); //그러면 결국 XFile로 가져올 필요가 없지 않나?

    //리스트 넘기는 법
    // TODO: 바꿔야할지도? join으로
    String interestCodesJson = "";
    if (interestCodes.isEmpty) {
      request.fields["interestCodes"] = interestCodesJson;
    } else {
      interestCodes.forEach((interestCode) {
        interestCodesJson = interestCodesJson + interestCode + ",";
      });
      interestCodesJson =
          interestCodesJson.substring(0, interestCodesJson.length - 1);
      request.fields["interestCodes"] = interestCodesJson;
    }

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

  //open api 사용
  @override
  Future<List<Major>> fetchMajors({required String searchText}) async {
    final response = await http.get(Uri.parse(
        "https://www.career.go.kr/cnet/openapi/getOpenApi?apiKey=ea3d8e66e599ebdbef51186142b8e1a8&svcType=api&svcCode=MAJOR&contentType=json&gubun=univ_list&thisPage=1&perPage=20&searchTitle=" +
            searchText));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var data = jsonResponse['dataSearch']['content'];

      List<Major> majors =
          await data.map<Major>((json) => Major.fromJson(json)).toList();

      return majors;
    } else {
      print(response.statusCode);
      throw Exception('open api 서버 오류');
    }
  }
}
