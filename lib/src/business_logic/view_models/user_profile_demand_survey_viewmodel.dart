import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/enums/collegeCode.dart';
import 'package:zamongcampus/src/business_logic/models/enums/interestStatus.dart';
import 'package:zamongcampus/src/business_logic/models/enums/majorCode.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/interest_object.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

class UserProfileDemandSurveyViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();
  UserProfilePresentation _userProfile = defaultUserProfile;
  List<InterestPresentation> _interests = [];
  final ScrollController _scrollController = ScrollController();

  UserProfilePresentation get userProfile => _userProfile;
  List<InterestPresentation> get userInterests => _interests;
  ScrollController get userProfileScrollController => _scrollController;

  static final UserProfilePresentation
      defaultUserProfile = //UserProfilePresentation 초기값 설정
      UserProfilePresentation(
    loginId: '',
    nickname: '',
    imageUrl: 'assets/images/user/general_user.png',
    collegeName: '',
    isOnline: false,
  );

  void loadUserProfile(String loginId) async {
    setBusy(true);
    // 여기서에서 유저의 정보 더 가져올 것!
    User user = await _userService.fetchUserInfo(loginId: loginId);
    _userProfile = UserProfilePresentation(
        loginId: user.loginId,
        nickname: user.nickname,
        imageUrl: user.imageUrl ?? defaultUserProfile.imageUrl,
        collegeName: CollegeData.korNameOf(
            describeEnum(user.collegeCode ?? CollegeCode.college0000)),
        majorName: MajorData.korNameOf(
            describeEnum(user.majorCode ?? MajorCode.major0000)),
        introduction: user.introduction);
    _interests = InterestObject.mapInterests(user.interests);
    setBusy(false);
  }
}

class UserProfilePresentation {
  final String loginId;
  final String nickname;
  final String imageUrl;
  final String collegeName;
  final String? majorName;
  final String? introduction;
  final bool? isOnline;

  UserProfilePresentation({
    required this.loginId,
    required this.nickname,
    required this.imageUrl,
    required this.collegeName,
    this.majorName,
    this.introduction,
    this.isOnline,
  });
}
