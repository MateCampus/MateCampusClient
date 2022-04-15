import 'package:flutter/foundation.dart';
import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';

import '../utils/college_data.dart';

class ProfileViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();

  ProfilePresentation _profile = defaultProfile;
  List<InterestPresentation> _interests = [];

  static final ProfilePresentation defaultProfile = //ProfilePresentation 초기값 설정
      ProfilePresentation(
          loginId: '',
          userNickname: '',
          userImageUrl: ['assets/images/user/general_user.png'],
          collegeName: '',
          isOnline: false,
          friendRequestStatus: FriendRequestStatus.none);

  ProfilePresentation get profile => _profile;
  List<InterestPresentation> get interests => _interests;

  void loadProfile(String userId) async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 1000)); // 딜레이
    User userProfileResult =
        await _userService.fetchUserProfile(userId: userId);
    _profile = ProfilePresentation(
        loginId: userProfileResult.loginId,
        userNickname: userProfileResult.userNickname,
        userImageUrl: userProfileResult.userImageUrls?.toList() ??
            defaultProfile.userImageUrl,
        collegeName: CollegeData.korNameOf(
            describeEnum(userProfileResult.collegeCode ?? College.college0000)),
        majorName: MajorData.korNameOf(
            describeEnum(userProfileResult.majorCode ?? Major.major0000)),
        userIntroduction: userProfileResult.userIntroduction,
        isOnline: userProfileResult.isOnline ?? defaultProfile.isOnline,
        friendRequestStatus: defaultProfile.friendRequestStatus);
    setBusy(false);
  }

  void loadInterests() async {
    _interests = interestDummy;
  }

  void requestFriend(String userId, String requestId) async {
    //userId: 친구신청 버튼을 누른 유저(본인)  requestId: 친구 신청 당하는 유저
    setBusy(true);
    _profile.friendRequestStatus = FriendRequestStatus.waiting;
    print(_profile.userNickname + '님에게 친구를 요청합니다'); //테스트용
    setBusy(false);
  }
}

class ProfilePresentation {
  final String loginId;
  final String userNickname;
  final List<String> userImageUrl;
  final String collegeName;
  final String? majorName;
  final String? userIntroduction;
  final bool isOnline;
  FriendRequestStatus friendRequestStatus;

  ProfilePresentation(
      {required this.loginId,
      required this.userNickname,
      required this.userImageUrl,
      required this.collegeName,
      this.majorName,
      this.userIntroduction,
      required this.isOnline,
      required this.friendRequestStatus});
}

enum FriendRequestStatus {
  none,
  waiting,
  done,
}

class InterestPresentation {
  final String title;
  final InterestStatus status;

  InterestPresentation({required this.title, required this.status});
}

enum InterestStatus {
  same,
  different,
  none,
}

List<InterestPresentation> interestDummy = [
  InterestPresentation(
      title: InterestData.iconOf(
              Interest(codeNum: InterestCode.i0001).codeNum.name) + //이렇게하는게 맞음
          " " +
          InterestData.korNameOf('i0001'),
      status: InterestStatus.same),
  InterestPresentation(
      title:
          InterestData.iconOf('i0002') + " " + InterestData.korNameOf('i0002'),
      status: InterestStatus.different),
  InterestPresentation(
      title:
          InterestData.iconOf('i0003') + " " + InterestData.korNameOf('i0003'),
      status: InterestStatus.none),
  InterestPresentation(
      title:
          InterestData.iconOf('i0004') + " " + InterestData.korNameOf('i0004'),
      status: InterestStatus.same),
  InterestPresentation(
      title:
          InterestData.iconOf('i0005') + " " + InterestData.korNameOf('i0005'),
      status: InterestStatus.none),
  InterestPresentation(
      title:
          InterestData.iconOf('i0006') + " " + InterestData.korNameOf('i0006'),
      status: InterestStatus.same),
  InterestPresentation(
      title:
          InterestData.iconOf('i0007') + " " + InterestData.korNameOf('i0007'),
      status: InterestStatus.none),
  InterestPresentation(
      title:
          InterestData.iconOf('i0008') + " " + InterestData.korNameOf('i0008'),
      status: InterestStatus.different),
  InterestPresentation(
      title:
          InterestData.iconOf('i0009') + " " + InterestData.korNameOf('i0009'),
      status: InterestStatus.same),
  InterestPresentation(
      title:
          InterestData.iconOf('i0010') + " " + InterestData.korNameOf('i0010'),
      status: InterestStatus.none),
  InterestPresentation(
      title:
          InterestData.iconOf('i0011') + " " + InterestData.korNameOf('i0011'),
      status: InterestStatus.none),
  InterestPresentation(
      title:
          InterestData.iconOf('i0012') + " " + InterestData.korNameOf('i0012'),
      status: InterestStatus.same),
  InterestPresentation(
      title:
          InterestData.iconOf('i0013') + " " + InterestData.korNameOf('i0013'),
      status: InterestStatus.same),
  InterestPresentation(
      title:
          InterestData.iconOf('i0014') + " " + InterestData.korNameOf('i0014'),
      status: InterestStatus.none),
  InterestPresentation(
      title:
          InterestData.iconOf('i0015') + " " + InterestData.korNameOf('i0015'),
      status: InterestStatus.none),
  InterestPresentation(
      title:
          InterestData.iconOf('i0016') + " " + InterestData.korNameOf('i0016'),
      status: InterestStatus.different),
];
