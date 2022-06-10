import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

class VoiceMainScreenViewModel extends BaseModel {
  final VoiceService _voiceService = serviceLocator<VoiceService>();
  final UserService _userService = serviceLocator<UserService>();

  final List<VoiceRoomPresentation> _voiceRooms = List.empty(growable: true);
  final List<UserPresentation> _recommendUsers = List.empty(growable: true);
  int _nextPageToken = 0;

  List<VoiceRoomPresentation> get voiceRooms => _voiceRooms;
  List<UserPresentation> get recommendUsers => _recommendUsers;

  // voiceMainInit() async {
  //   setBusy(true);
  //   await loadRecommendUsers();
  //   await loadVoiceRooms();
  //   setBusy(false);
  // }

  loadVoiceRooms() async {
    setBusy(true);
    List<VoiceRoom> voiceRoomsResult =
        await _voiceService.fetchVoiceRooms(nextPageToken: _nextPageToken);
    _voiceRooms
        .addAll(voiceRoomsResult.map((voiceRoom) => VoiceRoomPresentation(
              id: voiceRoom.id,
              title: voiceRoom.title ?? "제목 오류",
              memberImgUrls: voiceRoom.userImageUrls!
                  .map((image) => image.isEmpty
                      ? "assets/images/user/general_user.png"
                      : image)
                  .toList(),
              categories: categoryDummy[Random().nextInt(2)]
                  .map((category) =>
                      CategoryData.iconOf(category.name) +
                      " " +
                      CategoryData.korNameOf(category.name))
                  .toList(),
              createdAt: dateToPastTime(DateTime(2022, 2, 3)),
            )));

    _nextPageToken++;
    setBusy(false);
  }

  loadRecommendUsers() async {
    setBusy(true);
    List<User> userResult =
        await _userService.fetchRecommendUsers(nextPageToken: _nextPageToken);
    recommendUsers.addAll(userResult.map((user) => UserPresentation(
        loginId: user.loginId,
        imageUrl: user.imageUrl ?? "assets/images/user/general_user.png",
        collegeName: CollegeData.korNameOf(
            describeEnum(user.collegeCode ?? College.college0000)),
        majorName: MajorData.korNameOf(
            describeEnum(user.majorCode ?? Major.major0000)),
        isOnline: user.isOnline ?? false)));
    _nextPageToken++;
    setBusy(false);
  }
}

class VoiceRoomPresentation {
  final int id;
  final String title;
  final List<dynamic> memberImgUrls;
  final List<dynamic> categories;
  String createdAt;

  VoiceRoomPresentation(
      {required this.id,
      required this.title,
      required this.memberImgUrls,
      required this.categories,
      required this.createdAt});
}

class UserPresentation {
  String loginId;
  String imageUrl;
  String collegeName;
  String majorName;
  bool isOnline;

  UserPresentation(
      {required this.loginId,
      required this.imageUrl,
      required this.collegeName,
      required this.majorName,
      required this.isOnline});
}
