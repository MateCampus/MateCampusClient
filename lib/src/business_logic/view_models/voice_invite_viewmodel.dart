import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

import '../models/user.dart';

class VoiceInviteViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();
  final VoiceService _voiceService = serviceLocator<VoiceService>();

  List<UserPresentation> _recentTalkUsers = List.empty(growable: true);
  List<UserPresentation> _friendUsers = List.empty(growable: true);
  List<UserPresentation> _searchedRecentUsers = List.empty(growable: true);
  List<UserPresentation> _searchedFriendUsers = List.empty(growable: true);
  final List<String> _selectedMemberLoginIds = [];
  int voiceRoomId = -1;

  final TextEditingController _recentTalkSearchController =
      TextEditingController();
  final TextEditingController _friendSearchController = TextEditingController();

  List<UserPresentation> get recentTalkUsers => _recentTalkUsers;
  List<UserPresentation> get friendUsers => _friendUsers;
  TextEditingController get recentTalkSearchController =>
      _recentTalkSearchController;
  TextEditingController get friendSearchController => _friendSearchController;
  List<UserPresentation> get searchedRecentUsers => _searchedRecentUsers;
  List<UserPresentation> get searchedFriendUsers => _searchedFriendUsers;
  List<String> get selectedMemberLoginIds => _selectedMemberLoginIds;

  void loadRecentTalkUsersAndFriends(int voiceRoomId) async {
    setBusy(true);
    // 1. voiceRoomId 변경
    this.voiceRoomId = voiceRoomId;
    //로컬db에 저장된 최근 대화 유저 로그인 아이디를 서버에 넘긴 후 유저 정보 받아와서 매핑
    Map<String, List<User>> usersResult =
        await _userService.fetchRecentTalkUsersAndFriends();

    _recentTalkUsers = usersResult["recentTalkUsers"]!
        .map((recentTalkUser) => UserPresentation(
            loginId: recentTalkUser.loginId,
            userImageUrl: recentTalkUser.imageUrl ??
                "assets/images/user/general_user.png",
            userNickname: recentTalkUser.nickname,
            isOnlined: true,
            isChecked: false))
        .toList();

    _friendUsers = usersResult["approveFriends"]!
        .map((friendUser) => UserPresentation(
            loginId: friendUser.loginId,
            userImageUrl:
                friendUser.imageUrl ?? "assets/images/user/general_user.png",
            userNickname: friendUser.nickname,
            isOnlined: true,
            isChecked: false))
        .toList();

    setBusy(false);
  }

  //최근 대화친구 검색
  void searchRecentTalkUsers() {
    List<String> userNames = [];
    for (UserPresentation user in _recentTalkUsers) {
      userNames.add(user.userNickname);
    }
    _searchedRecentUsers = _recentTalkUsers.where((user) {
      return user.userNickname.startsWith(_recentTalkSearchController.text);
    }).toList();

    notifyListeners();
  }

//친구 검색
  void searchFriendUsers() {
    List<String> userNames = [];
    for (UserPresentation user in _friendUsers) {
      userNames.add(user.userNickname);
    }
    _searchedFriendUsers = _friendUsers.where((user) {
      return user.userNickname.startsWith(_friendSearchController.text);
    }).toList();

    notifyListeners();
  }

  void setMembers(UserPresentation user, bool value, String loginId) {
    user.isChecked = value;
    user.isChecked
        ? _selectedMemberLoginIds.add(loginId)
        : _selectedMemberLoginIds.remove(loginId);

    notifyListeners();
  }

  //검색텍스트필드 clear
  void clearSearchTextField(TextEditingController controller) {
    controller.clear();
    notifyListeners();
  }

  Future<void> inviteUsers(BuildContext context) async {
    bool success = await _voiceService.inviteUsers(
        id: voiceRoomId, selectedMemberLoginIds: selectedMemberLoginIds);
    Navigator.pop(context);
    success ? toastMessage("초대하셨습니다!") : toastMessage("초대 오류");
  }
}
