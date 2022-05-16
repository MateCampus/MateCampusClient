import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';

class SignUpViewModel extends BaseModel {
  final SignUpService _signUpService = serviceLocator<SignUpService>();

  /*뷰에서 접근이 필요한 변수 (서버로 보내야할 변수?)
  1. 아이디 텍스트 컨트롤러
  2. 패스워드 텍스트 컨트롤러
  3. 학교 (enum타입) 예시. VoiceRoomType _type = VoiceRoomType.PUBLIC;
  4. 학과 (enum타입)
  5. 학생증 사진 url -> post create 참고. XFile타입인듯
  6. 닉네임 텍스트 컨트롤러
  7. 관심사 리스트
  8. 프로필 사진 -> 이것도 XFile타입 일것같음
  */

  //아이디 관련 변수
  final _userIdFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get userIdFormKey => _userIdFormKey;
  final _userIdController = TextEditingController();
  TextEditingController get userIdController => _userIdController;
  bool _isValidId = false;
  bool get isValidId => _isValidId;

  //비밀번호 관련 변수
  final _userPwFormKey = GlobalKey<FormState>(); //이거 사용하는지 체크하기
  GlobalKey<FormState> get userPwFormKey => _userPwFormKey;
  final TextEditingController _userPwController = TextEditingController();
  TextEditingController get userPwController => _userPwController;

  bool _isValidPW = false;
  bool get isValidPW => _isValidPW;

  //학교선택 관련 변수
  String _selectedCollege = '학교를 선택해주세요';
  String get selectedCollege => _selectedCollege;

  //학과선택 관련 변수
  String _selectedMajor = '학과를 선택해주세요';
  String get selectedMajor => _selectedMajor;

  //학생증 이미지 경로 변수
  String _studentIdImgPath = '';
  String get studentIdImgPath => _studentIdImgPath;

  //이미지 선택 관련 변수
  //XFile? _pickedImg;
  final ImagePicker picker = ImagePicker();

  //닉네임 관련 변수
  final _userNicknameFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get userNicknameFormKey => _userNicknameFormKey;
  final _userNicknameController = TextEditingController();
  TextEditingController get userNicknameController => _userNicknameController;
  bool _isValidNickname = false;
  bool get isValidNickname => _isValidNickname;

  void checkIdRedundancy() async {
    //아이디 중복확인
    print(_isValidId); //테스트 용
    bool value =
        await _signUpService.checkIdRedundancy(id: _userIdController.text);
    _isValidId = value;
    print(_isValidId); //테스트 용

    _userIdFormKey.currentState!.validate(); //유효성 검사
  }

  String? idValidator(String? value) {
    if (value!.length < 5) {
      return '5자 이상 입력해주세요';
    } else if (value.length >= 5 && !_isValidId) {
      return '이미 사용중인 아이디입니다';
    } else {
      toastMessage('사용 가능한 아이디 입니다');
      return null;
    }
  }

  String? pwValidator(String? value) {
    //비밀번호 validator -> 추후 정책에따라 변경. ex) 특수문자+영어+숫자
    if (value!.length < 5) {
      return '비밀번호가 너무 짧아요!';
    } else {
      return null;
    }
  }

  String? pwDoubleCheckValidator(String? value) {
    if (value! != userPwController.text) {
      _isValidPW = false;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        notifyListeners();
      });
      return '비밀번호가 일치하지 않습니다';
    } else {
      _isValidPW = true;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        notifyListeners();
      });
      return null;
    }
  }

  void checkNicknameRedundancy() async {
    //닉네임 중복확인
    bool value = await _signUpService.checkNicknameRedundancy(
        nickname: _userNicknameController.text);
    _isValidNickname = value;

    _userNicknameFormKey.currentState!.validate(); //유효성 검사
  }

  String? nicknameValidator(String? value) {
    if (value!.length < 2) {
      return '두글자 이상 입력해주세요';
    } else if (value.length >= 2 && !_isValidNickname) {
      return '사용중인 닉네임입니다';
    } else {
      toastMessage('사용 가능한 닉네임 입니다');
      return null;
    }
  }

  void selectCollege(String value) {
    _selectedCollege = value;
    notifyListeners();
  }

  void selectMajor(String value) {
    _selectedMajor = value;
    notifyListeners();
  }

  //갤러리에서 이미지 가져옴(학생증)
  void getStudentIdCardFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _studentIdImgPath = image.path;
      notifyListeners();
    }
  }

  //카메라에서 이미지 가져옴(학생증)
  void getStudentIdCardFromCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _studentIdImgPath = image.path;
      notifyListeners();
    }
  }
}
