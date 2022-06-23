import 'package:flutter/foundation.dart';
import 'package:zamongcampus/src/business_logic/models/friend.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/interest_object.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';

import '../models/enums/collegeCode.dart';
import '../models/enums/friendRequestStatus.dart';
import '../models/enums/interestStatus.dart';
import '../models/enums/majorCode.dart';

class ProfileViewModel extends BaseModel {
  final FriendService _friendService = serviceLocator<FriendService>();
  ProfilePresentation _profile = defaultProfile;
  List<InterestPresentation> _interests = [];

  static final ProfilePresentation defaultProfile = //ProfilePresentation 초기값 설정
      ProfilePresentation(
          loginId: '',
          nickname: '',
          imageUrl: 'assets/images/user/general_user.png',
          collegeName: '',
          isOnline: false,
          friendRequestStatus: FriendRequestStatus.NONE);

  ProfilePresentation get profile => _profile;
  List<InterestPresentation> get interests => _interests;

  void loadProfile(int friendId) async {
    setBusy(true);
    Friend friend = await _friendService.fetchFriend(friendId);
    _profile = ProfilePresentation(
        loginId: friend.loginId,
        nickname: friend.nickname,
        imageUrl: friend.imageUrl ?? defaultProfile.imageUrl,
        collegeName: CollegeData.korNameOf(
            describeEnum(friend.collegeCode ?? CollegeCode.college0000)),
        majorName: MajorData.korNameOf(
            describeEnum(friend.majorCode ?? MajorCode.major0000)),
        introduction: friend.introduction,
        friendRequestStatus: friend.friendRequestStatus);
    _interests = InterestObject.mapInterests(friend.interests);

    setBusy(false);
  }
}

class ProfilePresentation {
  final String loginId;
  final String nickname;
  final String imageUrl;
  final String collegeName;
  final String? majorName;
  final String? introduction;
  final bool? isOnline;
  FriendRequestStatus friendRequestStatus;

  ProfilePresentation(
      {required this.loginId,
      required this.nickname,
      required this.imageUrl,
      required this.collegeName,
      this.majorName,
      this.introduction,
      this.isOnline,
      required this.friendRequestStatus});
}

/// user_profile과 일반 profile에서도 쓰임.
class InterestPresentation {
  final String title;
  final InterestStatus status;

  InterestPresentation({required this.title, required this.status});
}
