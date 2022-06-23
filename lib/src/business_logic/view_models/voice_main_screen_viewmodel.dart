import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/enums/majorCode.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/utils/voice_category_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

import '../models/enums/collegeCode.dart';

class VoiceMainScreenViewModel extends BaseModel {
  bool isInit = false;
  final VoiceService _voiceService = serviceLocator<VoiceService>();
  final UserService _userService = serviceLocator<UserService>();

  List<VoiceRoomPresentation> _voiceRooms = List.empty(growable: true);
  List<UserPresentation> _recommendUsers = List.empty(growable: true);
  int _voiceRoomNextPageToken = 0;
  int _recommendNextPageToken = 0;
  final ScrollController _scrollController = ScrollController();
  final _voiceMainRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  List<VoiceRoomPresentation> get voiceRooms => _voiceRooms;
  List<UserPresentation> get recommendUsers => _recommendUsers;
  ScrollController get voiceListScrollController => _scrollController;
  GlobalKey<RefreshIndicatorState> get voiceMainKey =>
      _voiceMainRefreshIndicatorKey;

  void initData() async {
    if (isInit) return;
    isInit = true;
    scrollInit();
    await loadVoiceRooms();
    await loadRecommendUsers();
  }

  void scrollInit() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _scrollController.offset > 0) {
        print("끝 지점 도착");
        //loadMoreVoiceRooms();
      }
    });
  }

  Future<void> refreshPage() async {
    _recommendNextPageToken = 0;
    _voiceRoomNextPageToken = 0;
    await loadVoiceRooms();
    await loadRecommendUsers();
  }

  loadVoiceRooms() async {
    setBusy(true);
    List<VoiceRoom> voiceRoomsResult = await _voiceService.fetchVoiceRooms(
        nextPageToken: _voiceRoomNextPageToken);
    _voiceRooms = voiceRoomsResult
        .map((voiceRoom) => VoiceRoomPresentation(
              id: voiceRoom.id,
              title: voiceRoom.title ?? "제목 오류",
              memberImgUrls: voiceRoom.userImageUrls
                      ?.map((image) =>
                          image ?? "assets/images/user/general_user.png")
                      .toList() ??
                  [],
              categories: voiceRoom.voiceCategoryCodes
                      ?.map<String>((category) =>
                          VoiceCategoryData.iconOf(category.name) +
                          " " +
                          VoiceCategoryData.korNameOf(category.name))
                      .toList() ??
                  [],
            ))
        .toList();

    _voiceRoomNextPageToken++;
    setBusy(false);
  }

  loadRecommendUsers() async {
    setBusy(true);
    List<User> userResult = await _userService.fetchRecommendUsers(
        nextPageToken: _recommendNextPageToken);
    _recommendUsers = userResult
        .map((user) => UserPresentation(
            loginId: user.loginId,
            imageUrl: user.imageUrl ?? "assets/images/user/general_user.png",
            collegeName: CollegeData.korNameOf(
                describeEnum(user.collegeCode ?? CollegeCode.college0000)),
            majorName: MajorData.korNameOf(
                describeEnum(user.majorCode ?? MajorCode.major0000)),
            isOnline: user.isOnline ?? false))
        .toList();
    _recommendNextPageToken++;
    setBusy(false);
  }

  Future<void> loadMoreVoiceRooms() async {
    buildShowDialogForLoading(
        context: _voiceMainRefreshIndicatorKey.currentContext!,
        barrierColor: Colors.transparent);
    List<VoiceRoom> additionalVoiceRooms = await _voiceService.fetchVoiceRooms(
        nextPageToken: _voiceRoomNextPageToken);
    if (additionalVoiceRooms.isEmpty) {
      toastMessage('더 이상 존재하는 대화방이 없어요\u{1F625}');
    } else if (additionalVoiceRooms.isNotEmpty) {
      _voiceRooms.addAll(additionalVoiceRooms
          .map((voiceRoom) => VoiceRoomPresentation(
                id: voiceRoom.id,
                title: voiceRoom.title ?? "제목 오류",
                memberImgUrls: voiceRoom.userImageUrls
                        ?.map((image) =>
                            image ?? "assets/images/user/general_user.png")
                        .toList() ??
                    [],
                categories: voiceRoom.voiceCategoryCodes
                        ?.map<String>((category) =>
                            VoiceCategoryData.iconOf(category.name) +
                            " " +
                            VoiceCategoryData.korNameOf(category.name))
                        .toList() ??
                    [],
              ))
          .toList());
      _voiceRoomNextPageToken++;
    }

    Navigator.pop(_voiceMainRefreshIndicatorKey.currentContext!);
    notifyListeners();
  }

  void resetData() {
    isInit = false;
  }
}

class VoiceRoomPresentation {
  final int id;
  final String title;
  final List<String> memberImgUrls;
  final List<String> categories;

  VoiceRoomPresentation({
    required this.id,
    required this.title,
    required this.memberImgUrls,
    required this.categories,
  });
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
