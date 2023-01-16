import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/arguments/chat_detail_from_friendProfile_screen_args.dart';
import 'package:zamongcampus/src/business_logic/models/enums/collegeCode.dart';
import 'package:zamongcampus/src/business_logic/models/post.dart';
import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/date_convert.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/utils/post_category_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/base_model.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/interest_object.dart';
import 'package:zamongcampus/src/object/prefs_object.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/ui/views/chat/chat_detail_from_friendProfile/chat_detail_from_friendProfile_screen.dart';

class UserProfileDemandSurveyViewModel extends BaseModel {
  final UserService _userService = serviceLocator<UserService>();
  final PostService _postService = serviceLocator<PostService>();
  final _userProfileRefreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = ScrollController();

  UserProfilePresentation _userProfile = defaultUserProfile;
  List<InterestPresentation> _interests = [];
  List<PostPresentation> _userPosts = List.empty(growable: true);

  bool isInit = false;
  int _nextPageToken = 0;
  final RegExp bodyRegexp = RegExp(r"\n+");

  PostMainScreenViewModel postMainScreenViewModel =
        serviceLocator<PostMainScreenViewModel>();

  UserProfilePresentation get userProfile => _userProfile;
  List<InterestPresentation> get userInterests => _interests;
  List<PostPresentation> get userPosts => _userPosts;
  ScrollController get userProfileScrollController => _scrollController;
  GlobalKey<RefreshIndicatorState> get userProfileMainKey =>
      _userProfileRefreshIndicatorKey;

  static final UserProfilePresentation
      defaultUserProfile = //UserProfilePresentation 초기값 설정
      UserProfilePresentation(
    loginId: '',
    nickname: '',
    imageUrl: 'assets/images/user/general_user.png',
    collegeName: '',
    introduction: '',
    isOnline: false,
  );

  void initData(String loginId) async {
    if (isInit) return;
    scrollInit(loginId);
    await loadUserProfileAndFeed(loginId);

    isInit = true;
  }

  void scrollInit(String loginId) {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          _scrollController.offset > 0) {
        print("끝 지점 도착");
        loadMoreUserPosts(loginId);
      }
    });
  }

  Future<void> loadUserProfileAndFeed(String loginId) async {
    setBusy(true);
    // 여기서에서 유저의 정보 더 가져올 것!
    User user = await _userService.fetchUserInfo(loginId: loginId);
    _userProfile = UserProfilePresentation(
        loginId: user.loginId,
        nickname: user.nickname,
        imageUrl: user.imageUrl ?? defaultUserProfile.imageUrl,
        collegeName: CollegeData.korNameOf(
            describeEnum(user.collegeCode ?? CollegeCode.college0000)),
        majorName: user.majorName ?? "",
        introduction: user.introduction ?? "");
    _interests = InterestObject.mapInterests(user.interests);

    //피드 가져오는 부분
    List<Post> result = await _postService.fetchUserPosts(
        targetLoginId: loginId, nextPageToken: _nextPageToken);
    _userPosts = result
        .map((post) => PostPresentation(
              id: post.id,
              loginId: post.loginId,
              userNickname: post.userNickname,
              categories: post.postCategoryCodes
                      ?.map<String>((category) =>
                          PostCategoryData.korNameOf(category.name))
                      .toList() ??
                  [],
              collegeName: CollegeData.korNameOf(describeEnum(
                  post.userCollegeCode ?? CollegeCode.college0000)),
              userImageUrl: post.userImageUrl.isNotEmpty
                  ? post.userImageUrl
                  : 'assets/images/user/general_user.png',
              body: post.body.replaceAll(bodyRegexp, " "),
              createdAt: dateToElapsedTime(post.createdAt),
              likedCount: post.likedCount.toString(),
              viewCount: post.viewCount.toString(),
              commentCount: post.commentCount.toString(),
              imageUrls: post.imageUrls,
               isLiked: postMainScreenViewModel.likepostIds.contains(post.id)? true:false
            ))
        .toList();

    _nextPageToken++;

    setBusy(false);
  }

  Future<void> loadMoreUserPosts(String loginId) async {
    buildShowDialogForLoading(
        context: _userProfileRefreshIndicatorKey.currentContext!,
        barrierColor: Colors.transparent);
    List<Post> additionalPosts = await _postService.fetchUserPosts(
        targetLoginId: loginId, nextPageToken: _nextPageToken);
    if (additionalPosts.isEmpty) {
      print('더 이상 가져올 피드 없음');
    } else {
      _userPosts.addAll(additionalPosts.map((post) => PostPresentation(
            id: post.id,
            loginId: post.loginId,
            userNickname: post.userNickname,
            categories: post.postCategoryCodes
                    ?.map<String>(
                        (category) => PostCategoryData.korNameOf(category.name))
                    .toList() ??
                [],
            collegeName: CollegeData.korNameOf(
                describeEnum(post.userCollegeCode ?? CollegeCode.college0000)),
            userImageUrl: post.userImageUrl.isNotEmpty
                ? post.userImageUrl
                : 'assets/images/user/general_user.png',
            body: post.body.replaceAll(bodyRegexp, " "),
            createdAt: dateToElapsedTime(post.createdAt),
            likedCount: post.likedCount.toString(),
            viewCount: post.viewCount.toString(),
            commentCount: post.commentCount.toString(),
            imageUrls: post.imageUrls,
             isLiked: postMainScreenViewModel.likepostIds.contains(post.id)? true:false
          )));
      _nextPageToken++;
    }
    Navigator.pop(_userProfileRefreshIndicatorKey.currentContext!);
    notifyListeners();
  }

   void likePost(PostPresentation post) async {
     Map<String, int> result = await _postService.likePost(postId: post.id);
    if(postMainScreenViewModel.likepostIds.contains(post.id)){
      postMainScreenViewModel.likepostIds.remove(result["postId"]!);
      post.isLiked = false;
    }else{
      postMainScreenViewModel.likepostIds.add(result["postId"]!);
      post.isLiked =true;
    }
    post.likedCount = result["likeCount"].toString();
    notifyListeners();
  }

  Future<void> refreshUserProfileToUpdate(String loginId) async {
    _interests.clear(); 
    _userPosts.clear();
    _nextPageToken = 0;
    await loadUserProfileAndFeed(loginId);
  }

  // Future<void> refreshUserProfileAndPost(String loginId) async {
  //   _userPosts.clear(); //포스트에 담았던거 다 비움
  //   _nextPageToken = 0;
  //   loadUserProfileAndFeed(loginId);
  // }

  void startChat(BuildContext context) async {
    bool isBlocked =
        await PrefsObject.getBlockedUserByLoginId(_userProfile.loginId);
    (isBlocked)
        ? toastMessage('대화를 걸 수 없는 상대입니다')
        : Navigator.pushNamed(
            context, ChatDetailFromFriendProfileScreen.routeName,
            arguments: ChatDetailFromFriendProfileScreenArgs(
                profileLoginId: _userProfile.loginId));
  }

  Future<void> blockUser(BuildContext context) async {
    //로컬 디비에 차단할 아이디 추가
    PrefsObject.setBlockedUser(_userProfile.loginId);

    //유저 차단
    await _userService.blockUser(targetLoginId: _userProfile.loginId);

    Navigator.pop(context);
    toastMessage('차단하였습니다');
  }
}

class UserProfilePresentation {
  final String loginId;
  final String nickname;
  final String imageUrl;
  final String collegeName;
  final String? majorName;
  final String introduction;
  final bool? isOnline;

  UserProfilePresentation({
    required this.loginId,
    required this.nickname,
    required this.imageUrl,
    required this.collegeName,
    this.majorName,
    required this.introduction,
    this.isOnline,
  });
}
