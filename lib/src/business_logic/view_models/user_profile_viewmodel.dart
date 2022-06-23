import 'package:flutter/foundation.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/interest_object.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

import '../models/enums/collegeCode.dart';
import '../models/enums/friendRequestStatus.dart';
import '../models/enums/majorCode.dart';

class UserProfileViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();
  final FriendService _friendService = serviceLocator<FriendService>();
  UserProfilePresentation _userProfile = defaultUserProfile;
  List<InterestPresentation> _interests = [];

  static final UserProfilePresentation
      defaultUserProfile = //UserProfilePresentation 초기값 설정
      UserProfilePresentation(
          loginId: '',
          nickname: '',
          imageUrl: 'assets/images/user/general_user.png',
          collegeName: '',
          isOnline: false,
          friendRequestStatus: FriendRequestStatus.NONE);

  UserProfilePresentation get profile => _userProfile;
  List<InterestPresentation> get interests => _interests;

  void loadUserProfile(String loginId) async {
    setBusy(true);
    // 여기서에서 유저의 정보 더 가져올 것!
    User recommendUser = await _userService.fetchUserInfo(loginId: loginId);
    _userProfile = UserProfilePresentation(
        loginId: recommendUser.loginId,
        nickname: recommendUser.nickname,
        imageUrl: recommendUser.imageUrl ?? defaultUserProfile.imageUrl,
        collegeName: CollegeData.korNameOf(
            describeEnum(recommendUser.collegeCode ?? CollegeCode.college0000)),
        majorName: MajorData.korNameOf(
            describeEnum(recommendUser.majorCode ?? MajorCode.major0000)),
        introduction: recommendUser.introduction,
        friendRequestStatus:
            recommendUser.friendRequestStatus ?? FriendRequestStatus.NONE);
    _interests = InterestObject.mapInterests(recommendUser.interests);
    setBusy(false);
  }

  void requestFriend(String targetLoginId) async {
    //userId: 친구신청 버튼을 누른 유저(본인)  requestId: 친구 신청 당하는 유저
    _userProfile.friendRequestStatus = FriendRequestStatus.UNACCEPTED;
    print(_userProfile.nickname + '님에게 친구를 요청합니다'); //테스트용
    _friendService.requestFriend(targetLoginId: targetLoginId);
    toastMessage('친구 신청 완료!');
    notifyListeners();
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
  FriendRequestStatus friendRequestStatus;

  UserProfilePresentation(
      {required this.loginId,
      required this.nickname,
      required this.imageUrl,
      required this.collegeName,
      this.majorName,
      this.introduction,
      this.isOnline,
      required this.friendRequestStatus});
}
