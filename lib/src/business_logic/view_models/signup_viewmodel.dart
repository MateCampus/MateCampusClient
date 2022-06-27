import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';

import '../models/enums/collegeCode.dart';
import '../models/enums/interestCode.dart';
import '../models/enums/majorCode.dart';

class SignUpViewModel extends BaseModel {
  final SignUpService _signUpService = serviceLocator<SignUpService>();

  ///아이디 관련 변수
  final _userIdFormKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController();
  bool _isValidId = false;

  GlobalKey<FormState> get userIdFormKey => _userIdFormKey;
  TextEditingController get userIdController => _userIdController;
  bool get isValidId => _isValidId;

  ///비밀번호 관련 변수
  final TextEditingController _userPwController = TextEditingController();
  bool _isValidPW = false;

  TextEditingController get userPwController => _userPwController;
  bool get isValidPW => _isValidPW;

  ///학교선택 관련 변수
  //enum형태의 모든 학교 리스트
  final List<CollegeCode> _collegeCodes = CollegeCode.values.toList();
  //전체 학교 이름 리스트 ex. 단국대학교
  List<String> _collegeNames = List.empty(growable: true);
  //검색 결과 리스트
  List<String> _searchingColleges = List.empty(growable: true);
  final TextEditingController _collegeController = TextEditingController();
  String _selectedCollegeCode = ''; //for server

  ///학과선택 관련 변수
  final List<MajorCode> _majorCodes = MajorCode.values.toList();
  List<String> _majorNames = List.empty(growable: true);
  List<String> _searchingMajors = List.empty(growable: true);
  final TextEditingController _majorController = TextEditingController();
  String _selectedMajorCode = '';
  int _majorIndex = -1;

  String get isSelectedCollege => _selectedCollegeCode;
  String get isSelectedMajor => _selectedMajorCode;
  TextEditingController get collegeController => _collegeController;
  TextEditingController get majorController => _majorController;
  List<String> get searchingColleges => _searchingColleges;
  List<String> get searchingMajors => _searchingMajors;

  ///학생증 이미지 관련 변수
  final ImagePicker picker = ImagePicker();
  XFile? _studentIdImg; //for server
  String _studentIdImgPath = ''; //for view

  String get studentIdImgPath => _studentIdImgPath;

  ///프로필 이미지 관련 변수
  XFile? _userImg; //for server
  String _userImgPath = ''; //for view

  String get userImgPath => _userImgPath;

  ///닉네임 관련 변수
  final _userNicknameFormKey = GlobalKey<FormState>();
  final _userNicknameController = TextEditingController();
  bool _isValidNickname = false;

  GlobalKey<FormState> get userNicknameFormKey => _userNicknameFormKey;
  TextEditingController get userNicknameController => _userNicknameController;
  bool get isValidNickname => _isValidNickname;

  ///관심사 관련 변수
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

  ///자기소개 관련 변수
  final _userIntroduceController = TextEditingController();
  TextEditingController get userIntroduceController => _userIntroduceController;

  ///focusnode -> 나중에 꼭 확인..
  //account 페이지에서 사용
  final accountFocusNode = FocusNode();

  ///scrollController
  //college 페이지에서 사용
  final ScrollController _scrollController = ScrollController();
  ScrollController get scrollController => _scrollController;

  ///overlay
  //college 페이지에서 사용
  OverlayEntry? collegeOverlayEntry;
  OverlayEntry? majorOverlayEntry;
  final LayerLink collegeLayerLink = LayerLink();
  final LayerLink majorLayerLink = LayerLink();

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
      _isValidId = false;
      toastMessage('아이디는 5자 이상이어야 합니다');
      return null;
    } else if (value.length >= 5 && !_isValidId) {
      _isValidId = false;
      toastMessage('이미 사용중인 아이디 입니다');
      return null;
    } else {
      toastMessage('사용 가능한 아이디입니다');
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
  String? nicknameValidator(BuildContext context, String? value) {
    if (value!.length < 2) {
      _isValidNickname = false;
      toastMessage('두 글자 이상 입력해주세요!');
      return null;
    } else if (value.length >= 2 && !_isValidNickname) {
      _isValidNickname = false;
      toastMessage('이미 사용 중인 닉네임입니다');
      return null;
    } else {
      FocusScope.of(context).unfocus();
      toastMessage('사용 가능한 닉네임 입니다');
      return null;
    }
  }

  void setCollegeList() {
    _collegeNames.clear();
    for (CollegeCode code in _collegeCodes) {
      _collegeNames.add(CollegeData.korNameOf(code.name));
    }
    // _collegeNames.removeAt(0);
  }

  void setMajorList() {
    _majorNames.clear();
    for (MajorCode code in _majorCodes) {
      _majorNames.add(MajorData.korNameOf(code.name));
    }
    // _majorNames.removeAt(0);
  }

  //학교 선택
  void selectCollege(BuildContext context, String college) {
    _collegeController.text = college;
    int collegeIndex = _collegeNames.indexOf(college);
    print("college index: " + collegeIndex.toString());
    _selectedCollegeCode = _collegeCodes[collegeIndex].name; //서버에 보낼용도
    print("college name: " + _selectedCollegeCode);

    //학교 선택시 커서 맨 끝으로
    _collegeController.selection = TextSelection.fromPosition(
        TextPosition(offset: _collegeController.text.length));

    //학교를 선택하는 시점에서 이미 선택된 학과가 있다면 초기화 .(타 대학 동일학과 선택 방지위함)
    _selectedMajorCode = '';
    _majorController.clear();
    searchMajor();
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  //학교 검색
  void searchCollege() {
    _searchingColleges = _collegeNames.sublist(1).where((collegeName) {
      return collegeName.contains(_collegeController.text);
    }).toList();

    notifyListeners();
  }

  //학과 선택 텍스트필드 눌렀을 때 스크롤 업 해주는 함수
  void scrollMajorFieldToTop() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _scrollController.animateTo(getProportionateScreenHeight(100),
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
  }

  //학과 선택
  void selectMajor(BuildContext context, String major) {
    _majorController.text = major;
    switch (_selectedCollegeCode) {
      case 'college0001':
        _majorIndex = _majorNames.sublist(1, 45).indexOf(major) + 1;
        break;
      case 'college0002':
        _majorIndex = _majorNames.sublist(45).indexOf(major) + 45;
        break;
    }
    print("major index: " + _majorIndex.toString());
    _selectedMajorCode = _majorCodes[_majorIndex].name; //서버에 보낼용도
    print("major name: " + _selectedMajorCode);

    //학과 선택시 커서 맨 끝으로
    _majorController.selection = TextSelection.fromPosition(
        TextPosition(offset: _majorController.text.length));
    notifyListeners();

    FocusScope.of(context).unfocus();
  }

  //학과 검색
  void searchMajor() {
    switch (_selectedCollegeCode) {
      case 'college0001':
        _searchingMajors = _majorNames.sublist(1, 45).where((majorName) {
          return majorName.contains(_majorController.text);
        }).toList();
        break;
      case 'college0002':
        _searchingMajors = _majorNames.sublist(45).where((majorName) {
          return majorName.contains(_majorController.text);
        }).toList();
        break;
    }

    notifyListeners();
  }

  //갤러리에서 이미지 가져옴(학생증)
  void getStudentIdCardFromGallery(BuildContext context) async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    FocusScope.of(context).unfocus();
    if (image != null) {
      _studentIdImg = image;
      _studentIdImgPath = image.path;

      notifyListeners();
    }
  }

  //카메라에서 이미지 가져옴(학생증)
  void getStudentIdCardFromCamera(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _studentIdImg = image;
      _studentIdImgPath = image.path;
      notifyListeners();
    }
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

  void createCollegeOverlay(BuildContext context, OverlayEntry overlayWidget) {
    if (collegeOverlayEntry == null) {
      collegeOverlayEntry = overlayWidget;
      Overlay.of(context)?.insert(collegeOverlayEntry!);
    }

    notifyListeners();
  }

  void createMajorOverlay(BuildContext context, OverlayEntry overlayWidget) {
    if (majorOverlayEntry == null) {
      majorOverlayEntry = overlayWidget;
      Overlay.of(context)?.insert(majorOverlayEntry!);
    }

    notifyListeners();
  }

  void removeCollegeOverlay() {
    collegeOverlayEntry?.remove();
    collegeOverlayEntry = null;
    notifyListeners();
  }

  void removeMajorOverlay() {
    majorOverlayEntry?.remove();
    majorOverlayEntry = null;
    notifyListeners();
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
