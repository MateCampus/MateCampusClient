import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/major.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';

import '../models/enums/collegeCode.dart';
import '../models/enums/interestCode.dart';

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
  List<MajorPresentation> _majors = List.empty(growable: true);
  final TextEditingController _majorController = TextEditingController();
  MajorPresentation _selectedMajor =
      MajorPresentation(title: '', seq: ''); //for server

  String get isSelectedCollege => _selectedCollegeCode;
  MajorPresentation get isSelectedMajor => _selectedMajor;
  TextEditingController get collegeController => _collegeController;
  TextEditingController get majorController => _majorController;
  List<String> get searchingColleges => _searchingColleges;
  List<MajorPresentation> get majors => _majors;

  //학과,학교 요청 관련 변수
  final TextEditingController _requestController = TextEditingController();
  bool _isRequested = false;
  TextEditingController get requestController => _requestController;
  bool get isRequested => _isRequested;

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

  //학년 관련 변수
  final List<String> _gradeList = ['1학년', '2학년', '3학년', '4학년', '그 외'];
  List<String> get gradeList => _gradeList;
  int _gradeIndex = 0;
  int get gradeIndex => _gradeIndex;

  //성별 관련 변수
  final List<String> _genderList = ['여자', '남자'];
  List<String> get genderList => _genderList;
  int genderIndex = -1;
  bool _genderValue = true;

  //생년월일 관련 변수
  String _birthday = '0000-00-00'; //for server
  String get birthday => _birthday;

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
  final ScrollController _collegeScrollController = ScrollController();
  ScrollController get collegeScrollController => _collegeScrollController;
  //opntional 페이지에서 사용
  final ScrollController _optionalProfileScrollController = ScrollController();
  ScrollController get optionalProfileScrollController =>
      _optionalProfileScrollController;

  ///overlay
  //college 페이지에서 사용
  OverlayEntry? collegeOverlayEntry;
  OverlayEntry? majorOverlayEntry;
  final LayerLink collegeLayerLink = LayerLink();
  final LayerLink majorLayerLink = LayerLink();

  // 아이디 중복확인
  Future<void> checkIdRedundancy(BuildContext context) async {
    FocusScope.of(context).unfocus();
    bool value =
        await _signUpService.checkIdRedundancy(id: _userIdController.text);
    _isValidId = value;
    _userIdFormKey.currentState!
        .validate(); //유효성 검사 -> 결국 여기서 idValidator가 실행됨.
  }

  //아이디 validator
  String? idValidator(String? value, BuildContext context) {
    if (_isValidId && _isValidPW) {
      //다음페이지로 이동
      Navigator.pushNamed(context, "/signUpCollege");
      return null;
    } else if (_isValidId && !_isValidPW) {
      return null;
    } else {
      return '이미 사용중인 아이디 입니다';
    }
  }

  //비밀번호 validator -> 추후 정책에따라 변경. ex) 특수문자+영어+숫자
  String? pwValidator(String? value) {
    if (value!.length < 5) {
      _isValidPW = false;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        notifyListeners();
      });
      return '비밀번호가 너무 짧아요!';
    } else {
      _isValidPW = true;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        notifyListeners();
      });
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
  void checkNicknameRedundancy(BuildContext context) async {
    FocusScope.of(context).unfocus();
    bool value = await _signUpService.checkNicknameRedundancy(
        nickname: _userNicknameController.text);
    _isValidNickname = value;
    _userNicknameFormKey.currentState!
        .validate(); //유효성 검사 -> nicknameValidator실행
  }

  //닉네임 validator
  String? nicknameValidator(BuildContext context, String? value) {
    //닉네임이 유효하고, 모든 항목들이 다 채워져야 다음장으로 넘어갈수있음 근데 일단 모든 항목들이 다 채워지지 않으면 다음이 활성화가 안돼야하니까..
    //그럼 여기서는 그냥 닉네임의 유효성 유무만 판단하면 된다.
    if (_isValidNickname) {
      //다음페이지로 이동해야함
      Navigator.pushNamed(context, '/signUpOptionalProfile');
      return null;
    } else if (!_isValidNickname) {
      return '이미 사용 중인 닉네임입니다';
    } else {
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
    // _selectedMajorCode = '';
    // _majorController.clear();
    // searchMajor();
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

  //학과 선택 텍스트필드 눌렀을 때 스크롤 업 해주는 함수 -> 일단은 안씀
  void scrollMajorFieldToTop() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _collegeScrollController.animateTo(getProportionateScreenHeight(220),
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
  }

  //학교 선택 텍스트필드 눌렀을 때 스크롤 업 해주는 함수
  void scrollCollegeFieldToTop() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _collegeScrollController.animateTo(getProportionateScreenHeight(120),
          duration: const Duration(milliseconds: 400),
          curve: Curves.fastOutSlowIn);
    });
  }

  //내 소개 눌렀을 때 스크롤 업 해주는 함수
  void scrollIntroduceFieldToTop() async {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _optionalProfileScrollController.animateTo(
          getProportionateScreenHeight(100),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut);
    });
  }

  //학과 선택
  void selectMajor(BuildContext context, MajorPresentation selectedMajor) {
    _majorController.text = selectedMajor.title;
    _selectedMajor = selectedMajor;

    //학과 선택시 커서 맨 끝으로
    _majorController.selection = TextSelection.fromPosition(
        TextPosition(offset: _majorController.text.length));

    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  //학과 검색 -> open api 사용
  Future<void> searchMajor() async {
    _majors.clear();
    List<Major> majorResult =
        await _signUpService.fetchMajors(searchText: _majorController.text);
    _majors = majorResult
        .map((major) =>
            MajorPresentation(title: major.mClass, seq: major.majorSeq))
        .toList();

    notifyListeners();
  }

  // 학과 요청
  Future<void> requestMajor(BuildContext context) async {
    bool value =
        await _signUpService.requestMajor(body: _requestController.text);
    if (value) {
      _isRequested = true;
      //서버로 보낼 학과 값을 major.0000 으로 지정
      // _selectedMajorCode = _majorCodes.first.name;
      // print(_selectedMajorCode);
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
    } else {}
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
    buildDialogForNotice(
        context: context,
        description:
            '\u{2757}본인의 학교와 학과를 인증할 수 있는 학생증 혹은 웹정보 사진을 올려주세요\n\n(학교/학과 정보 외의 개인정보는 모두 가려주세요)');
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
    buildDialogForNotice(
        context: context,
        description:
            '\u{2757}본인의 학교와 학과를 인증할 수 있는 학생증 혹은 웹정보 사진을 올려주세요\n\n(학교/학과 정보 외의 개인정보는 모두 가려주세요)');
  }

  //set gradeIndex
  void changeGradeIndex(int index) {
    _gradeIndex = index;
    print(_gradeIndex.toString());
    notifyListeners();
  }

  //set gender
  void changeGenderIndex(int index) {
    genderIndex = index;
    if (genderIndex == 0) {
      _genderValue = false;
    } else if (genderIndex == 1) {
      _genderValue = true;
    }
    print(_genderValue.toString());
    notifyListeners();
  }

  //생일지정
  void setBirthDay(DateTime date) {
    _birthday = dateToYearMonthDay(date);
    print(_birthday);
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

    for (InterestPresentation i in _selectedInterests) {
      print(i.title);
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
        mClass: _selectedMajor.title,
        majorSeq: _selectedMajor.seq,
        studentIdImg: _studentIdImg!,
        nickname: _userNicknameController.text,
        grade: _gradeIndex.toString(),
        gender: _genderValue.toString(),
        birth: _birthday,
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
      print('회원가입 오류');
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

class MajorPresentation {
  final String title;
  final String seq;

  MajorPresentation({required this.title, required this.seq});
}
