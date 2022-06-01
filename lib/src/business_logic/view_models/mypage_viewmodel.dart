import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

import '../../services/interest/interest_service.dart';

class MypageViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();
  final InterestService _interestService = serviceLocator<InterestService>();
  MypagePresentation _myInfo = defaultInfo;
  final List<InterestPresentation> _allInterestsAfterLoad =
      List.empty(growable: true);
  List<InterestCode> _selectedInterestCodes = List.empty(growable: true);

  static final MypagePresentation defaultInfo = MypagePresentation(
    nickname: '',
    imageUrl: 'assets/images/user/general_user.png',
    collegeName: '',
    interestCount: '',
    friendCount: '17',
    bookMarkCount: '2',
    feedCount: '21',
    commentCount: '5',
  );

  MypagePresentation get myInfo => _myInfo;
  List<InterestPresentation> get allInterestsAfterLoad =>
      _allInterestsAfterLoad;

  List<InterestCode> get selectedInterestCodes => _selectedInterestCodes;

  void loadMyInfo(String loginId) async {
    setBusy(true);

    User myInfoResult = await _userService.fetchMyInfo();

    _myInfo = MypagePresentation(
        nickname: myInfoResult.nickname,
        imageUrl: myInfoResult.imageUrl ?? defaultInfo.imageUrl,
        collegeName: CollegeData.korNameOf(
            describeEnum(myInfoResult.collegeCode ?? College.college0000)),
        majorName: MajorData.korNameOf(
            describeEnum(myInfoResult.majorCode ?? Major.major0000)),
        introduction: myInfoResult.introduction,
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
      List<Interest> selectedInterestResults =
          await _interestService.fetchMyInterests();
      _selectedInterestCodes =
          selectedInterestResults.map((interest) => interest.codeNum).toList();
      for (InterestCode systemInterest in allInterestList) {
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

  void updateMyInfo(
      {String? nickname,
      String? introduction,
      String? imageUrl,
      required BuildContext context}) async {
    (nickname == _myInfo.nickname)
        ? nickname = null
        : _myInfo.nickname = nickname!;
    (introduction == _myInfo.introduction || introduction == '')
        ? introduction = null
        : _myInfo.introduction = introduction!;
    (imageUrl == '') ? imageUrl = null : _myInfo.imageUrl; //

    //서버에 값 넘길때는 인자들이 null이 아닌것만 넘기면 됨.

    notifyListeners();
    Navigator.pop(context);
    toastMessage('프로필 변경 완료!');
  }

  void updateInterests({required BuildContext context}) async {
    buildShowDialog(context);
    int interestCount =
        await _interestService.updateMyInterests(_selectedInterestCodes);

    _myInfo.interestCount = interestCount.toString();
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
  final String? majorName;
  String? introduction;

  String interestCount;
  final String friendCount;
  final String bookMarkCount;
  final String feedCount;
  final String commentCount;

  MypagePresentation(
      {required this.nickname,
      required this.imageUrl,
      required this.collegeName,
      this.majorName,
      this.introduction,
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
