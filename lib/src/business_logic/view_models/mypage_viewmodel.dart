import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/interest_object.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import '../../services/interest/interest_service.dart';
import '../models/enums/collegeCode.dart';
import '../models/enums/interestCode.dart';
import '../models/enums/majorCode.dart';

class MypageViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();
  final SignUpService _signUpService = serviceLocator<SignUpService>();
  final InterestService _interestService = serviceLocator<InterestService>();
  MypagePresentation _myInfo = defaultInfo;
  static final MypagePresentation defaultInfo = MypagePresentation(
    nickname: '',
    imageUrl: 'assets/images/user/general_user.png',
    collegeName: '',
    majorName: '',
    introduction: '',
    interestCount: '',
    friendCount: '-1',
    bookMarkCount: '-1',
    feedCount: '-1',
    commentCount: '-1',
  );

  //관심사 관련 변수
  final List<InterestPresentation> _allInterestsAfterLoad =
      List.empty(growable: true);
  List<InterestCode> _selectedInterestCodes = List.empty(growable: true);

  //프로필사진 관련 변수
  final ImagePicker picker = ImagePicker();
  XFile? _changedProfileImg;
  String _changedProfileImgPath = ''; //for view

  //닉네임 변경 관련 변수
  final _nicknameFormKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  String? _changedNickname;
  bool _isValidNickname = false;

  //소개글 변경 관련 변수
  final _introductionController = TextEditingController();
  String? _changedIntroduction;
  bool _isValidIntroduction = false;

  //뷰에서 접근이 필요한 변수
  MypagePresentation get myInfo => _myInfo;
  List<InterestPresentation> get allInterestsAfterLoad =>
      _allInterestsAfterLoad;
  List<InterestCode> get selectedInterestCodes => _selectedInterestCodes;
  String get changedProfileImgPath => _changedProfileImgPath;
  GlobalKey<FormState> get nicknameFormKey => _nicknameFormKey;
  TextEditingController get nicknameController => _nicknameController;
  bool get isValidNickname => _isValidNickname;
  TextEditingController get introductionController => _introductionController;
  bool get isValidIntroduction => _isValidIntroduction;

  void loadMyInfo() async {
    setBusy(true);

    User myInfoResult = await _userService.fetchMyInfo();

    _myInfo = MypagePresentation(
        nickname: myInfoResult.nickname,
        imageUrl: myInfoResult.imageUrl ?? defaultInfo.imageUrl,
        collegeName: CollegeData.korNameOf(
            describeEnum(myInfoResult.collegeCode ?? CollegeCode.college0000)),
        majorName: MajorData.korNameOf(
            describeEnum(myInfoResult.majorCode ?? MajorCode.major0000)),
        introduction: myInfoResult.introduction ?? defaultInfo.introduction,
        interestCount: myInfoResult.interestCount.toString(),
        friendCount: myInfoResult.friendCount.toString(),
        bookMarkCount: myInfoResult.bookMarkCount.toString(),
        feedCount: myInfoResult.myPostCount.toString(),
        commentCount: myInfoResult.myCommentCount.toString());
    setBusy(false);
  }

  void loadMyInterest() async {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      setBusy(true);
      List<Interest> selectedInterestResults = InterestObject.myInterests;
      _selectedInterestCodes =
          selectedInterestResults.map((interest) => interest.codeNum).toList();
      for (InterestCode systemInterest in InterestCode.values) {
        bool hasData = selectedInterestCodes.contains(systemInterest);
        _allInterestsAfterLoad.add(InterestPresentation(
            codeNum: systemInterest,
            title: InterestData.korNameOf(systemInterest.name),
            icon: InterestData.iconOf(systemInterest.name),
            isSelected: hasData));
      }
      setBusy(false);
    });
  }

  void changeInterestStatus(InterestPresentation interest, bool value) {
    interest.isSelected = value;
    if (interest.isSelected == false) {
      _selectedInterestCodes.remove(interest.codeNum);
    } else if (interest.isSelected == true) {
      _selectedInterestCodes.add(interest.codeNum);
    }
    notifyListeners();
  }

  //갤러리에서 새로운 프사 선택
  void getProfileImgFromGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _changedProfileImg = image;
      _changedProfileImgPath = image.path;
      notifyListeners();
    }
  }

//닉네임 변경(감지)
  void updateNickname() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      _changedNickname = _nicknameController.text;
      notifyListeners();
    });
  }

//소개글 변경
  void updateIntroduction() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (_introductionController.text == _myInfo.introduction) {
        _isValidIntroduction = false;
      } else {
        _changedIntroduction = _introductionController.text;
        _isValidIntroduction = true;
      }
      notifyListeners();
    });
  }

  //닉네임 중복확인
  void checkNicknameRedundancy() async {
    bool value =
        await _signUpService.checkNicknameRedundancy(nickname: _changedNickname!);

    _isValidNickname = value;
    //유효성 검사 -> 이 때 nicknameValidator실행
    _nicknameFormKey.currentState!.validate();
    notifyListeners();
  }

  //닉네임 validator
  String? nicknameValidator(String? value) {
    if (_isValidNickname) {
      toastMessage('사용 가능한 닉네임 입니다');
      return null;
    } else if (!_isValidNickname) {
      return '이미 사용 중인 닉네임입니다';
    } else {
      return null;
    }
  }

  void updateMyInfo({required BuildContext context}) async {
    buildShowDialogForLoading(context: context);
    User updatedUserResult = await _userService.updateMyInfo(
        nickname: _changedNickname,
        introduction: _changedIntroduction,
        profileImg: _changedProfileImg);

    _myInfo.nickname = updatedUserResult.nickname;
    _myInfo.imageUrl = updatedUserResult.imageUrl ?? _myInfo.imageUrl;
    _myInfo.introduction =
        updatedUserResult.introduction ?? _myInfo.introduction;

    _isValidNickname = false;
    _isValidIntroduction = false;
    _changedProfileImgPath = '';
    notifyListeners();
    Navigator.popUntil(context, ModalRoute.withName('/'));
    toastMessage('프로필 변경 완료!');
  }

  void updateInterests({required BuildContext context}) async {
    buildShowDialogForLoading(context: context);
    List<Interest> updateInterests =
        await _interestService.updateMyInterests(_selectedInterestCodes);

    _myInfo.interestCount = updateInterests.length.toString();
    InterestObject.updateMyInterests(updateInterests);
    notifyListeners();
    Navigator.popUntil(context, ModalRoute.withName('/'));
    toastMessage('관심사 변경 완료!');
  }

  void resetInterests() {
    _allInterestsAfterLoad.clear();
  }
}

class MypagePresentation {
  String nickname;
  String imageUrl;
  final String collegeName;
  final String majorName;
  String introduction;

  String interestCount;
  final String friendCount;
  final String bookMarkCount;
  final String feedCount;
  final String commentCount;

  MypagePresentation(
      {required this.nickname,
      required this.imageUrl,
      required this.collegeName,
      required this.majorName,
      required this.introduction,
      required this.interestCount,
      required this.friendCount,
      required this.bookMarkCount,
      required this.feedCount,
      required this.commentCount});
}

class InterestPresentation {
  final InterestCode codeNum;
  final String title;
  final String icon;
  bool isSelected;

  InterestPresentation(
      {required this.codeNum,
      required this.title,
      required this.icon,
      required this.isSelected});
}
