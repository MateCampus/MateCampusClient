import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';

import '../models/enums/collegeCode.dart';
import '../models/enums/interestCode.dart';
import '../models/enums/majorCode.dart';

class SignUpViewModel extends BaseModel {
  final SignUpService _signUpService = serviceLocator<SignUpService>();

  //아이디 관련 변수
  final _userIdFormKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  bool _isValidId = false;

  GlobalKey<FormState> get userIdFormKey => _userIdFormKey;
  TextEditingController get userIdController => _userIdController;
  bool get isValidId => _isValidId;

  //비밀번호 관련 변수
  final TextEditingController _userPwController = TextEditingController();
  bool _isValidPW = false;

  TextEditingController get userPwController => _userPwController;
  bool get isValidPW => _isValidPW;

  //학교선택 관련 변수
  String _selectedCollegeCode = ''; //for server
  String _selectedCollegeName = ''; //for view

  String get selectedCollege => _selectedCollegeName;

  //학과선택 관련 변수
  String _selectedMajorCode = '';
  String _selectedMajorName = '';

  String get selectedMajor => _selectedMajorName;

  //학생증 이미지 관련 변수
  final ImagePicker picker = ImagePicker();
  XFile? _studentIdImg; //for server
  String _studentIdImgPath = ''; //for view

  String get studentIdImgPath => _studentIdImgPath;

  //프로필 이미지 관련 변수
  XFile? _userImg; //for server
  String _userImgPath = ''; //for view

  String get userImgPath => _userImgPath;

  //닉네임 관련 변수
  final _userNicknameFormKey = GlobalKey<FormState>();
  final _userNicknameController = TextEditingController();
  bool _isValidNickname = false;

  GlobalKey<FormState> get userNicknameFormKey => _userNicknameFormKey;
  TextEditingController get userNicknameController => _userNicknameController;
  bool get isValidNickname => _isValidNickname;

  //관심사 관련 변수
  //_systemInterests => 전체관심사 매핑한 리스트.
  static final List<InterestPresentation> _systemInterests = InterestCode.values
      .map((interestCode) => InterestPresentation(
          interestCode: interestCode,
          title: InterestData.korNameOf(interestCode.name),
          icon: InterestData.iconOf(interestCode.name),
          isSelected: false))
      .toList();
  final List<InterestPresentation> _selectedInterests =
      List.empty(growable: true);

  List<InterestPresentation> get systemInterests => _systemInterests;
  List<InterestPresentation> get selectedInterests => _selectedInterests;

  //자기소개 관련 변수
  final _userIntroduceController = TextEditingController();
  TextEditingController get userIntroduceController => _userIntroduceController;

  // 아이디 중복확인
  void checkIdRedundancy() async {
    bool value =
        await _signUpService.checkIdRedundancy(id: _userIdController.text);
    _isValidId = value;
    _userIdFormKey.currentState!.validate(); //유효성 검사
  }

  //아이디 validator
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

  //비밀번호 validator -> 추후 정책에따라 변경. ex) 특수문자+영어+숫자
  String? pwValidator(String? value) {
    if (value!.length < 5) {
      return '비밀번호가 너무 짧아요!';
    } else {
      return null;
    }
  }

  //비밀번호 확인 validator
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

  //닉네임 중복확인
  void checkNicknameRedundancy() async {
    bool value = await _signUpService.checkNicknameRedundancy(
        nickname: _userNicknameController.text);
    _isValidNickname = value;
    _userNicknameFormKey.currentState!.validate(); //유효성 검사
  }

  //닉네임 validator
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

  //학교 선택
  void selectCollege(CollegeCode college) {
    _selectedCollegeCode = college.name; //서버에 보낼용도
    _selectedCollegeName = CollegeData.korNameOf(college.name); //뷰에서 쓰는 용도
    notifyListeners();
  }

  //학과 선택
  void selectMajor(MajorCode major) {
    _selectedMajorCode = major.name; //서버에 보낼용도
    _selectedMajorName = MajorData.korNameOf(major.name);
    notifyListeners();
  }

  //갤러리에서 이미지 가져옴(학생증)
  void getStudentIdCardFromGallery(BuildContext context) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _studentIdImg = image;
      _studentIdImgPath = image.path;
      notifyListeners();
    }
    Navigator.pop(context);
  }

  //카메라에서 이미지 가져옴(학생증)
  void getStudentIdCardFromCamera(BuildContext context) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _studentIdImg = image;
      _studentIdImgPath = image.path;
      notifyListeners();
    }
    Navigator.pop(context);
  }

  //갤러리에서 이미지 가져옴(프사)
  void getUserImgFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _userImg = image;
      _userImgPath = image.path;
      notifyListeners();
    }
  }

  //관심사 선택
  void selectInterest(InterestPresentation interest, bool value) {
    interest.isSelected = value;
    if (interest.isSelected == false) {
      _selectedInterests.remove(interest);
    } else if (interest.isSelected == true) {
      _selectedInterests.add(interest);
    }
    notifyListeners();
  }

  //유저 생성
  Future<void> createUser(BuildContext context) async {
    buildShowDialogForLoading(context: context);
    bool isCreated = await _signUpService.createUser(
        id: _userIdController.text,
        pw: _userPwController.text,
        collegeCode: _selectedCollegeCode.toUpperCase(),
        majorCode: _selectedMajorCode.toUpperCase(),
        studentIdImg: _studentIdImg!,
        nickname: _userNicknameController.text,
        interestCodes: _selectedInterests
            .map((selectedInterest) =>
                selectedInterest.interestCode.name.toUpperCase())
            .toList(),
        profileImg: _userImg,
        introduce: _userIntroduceController.text);

    if (isCreated) {
      toastMessage('회원 가입이 완료되었습니다');
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } else {
      toastMessage('회원가입 오류');
    }
  }
}

class InterestPresentation {
  final InterestCode interestCode;
  final String title;
  final String icon;
  bool isSelected;

  InterestPresentation(
      {required this.interestCode,
      required this.title,
      required this.icon,
      required this.isSelected});
}
