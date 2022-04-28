import 'package:flutter/foundation.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

class VoiceMainScreenViewModel extends BaseModel {
  final VoiceService _voiceService = serviceLocator<VoiceService>();
  final UserService _userService = serviceLocator<UserService>();

  List<VoiceRoomPresentation> voiceRooms = [];
  List<UserPresentation> recommendUsers = [];
  int nextPageToken = 0;

  void loadVoiceRooms() async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500)); // 0.5초 딜레이
    List<VoiceRoom> voiceRoomsResult =
        await _voiceService.fetchVoiceRooms(nextPageToken: nextPageToken);
    voiceRooms.addAll(voiceRoomsResult.map((voiceRoom) => VoiceRoomPresentation(
        id: voiceRoom.id,
        title: voiceRoom.title,
        memberImageUrls: voiceRoom.members
            .map((member) =>
                member.imageUrls?.first ??
                "assets/images/user/general_user.png")
            .toList(),
        categories: voiceRoom.categories
            .map((category) =>
                CategoryData.iconOf(category.name) +
                " " +
                CategoryData.korNameOf(category.name))
            .toList(),
        createdAt: dateToPastTime(voiceRoom.createdAt))));

    nextPageToken++;
    setBusy(false);
  }

  void loadRecommendUsers() async {
    setBusy(true);
    await Future.delayed(const Duration(milliseconds: 500)); // 0.5초 딜레이
    List<User> userResult =
        await _userService.fetchRecommendUsers(nextPageToken: nextPageToken);
    recommendUsers.addAll(userResult.map((user) => UserPresentation(
        loginId: user.loginId,
        userImageUrls:
            user.imageUrls ?? ["assets/images/user/general_user.png"],
        collegeName: CollegeData.korNameOf(
            describeEnum(user.collegeCode ?? College.college0000)),
        majorName: MajorData.korNameOf(
            describeEnum(user.majorCode ?? Major.major0000)),
        isOnline: user.isOnline ?? false)));
    nextPageToken++;
    setBusy(false);
  }
}

class VoiceRoomPresentation {
  final int id;
  final String title;
  final List<String> memberImageUrls;
  final List<dynamic> categories;
  String createdAt;

  VoiceRoomPresentation(
      {required this.id,
      required this.title,
      required this.memberImageUrls,
      required this.categories,
      required this.createdAt});
}

class UserPresentation {
  String loginId;
  List<String> userImageUrls;
  String collegeName;
  String majorName;
  bool isOnline;

  UserPresentation(
      {required this.loginId,
      required this.userImageUrls,
      required this.collegeName,
      required this.majorName,
      required this.isOnline});
}
