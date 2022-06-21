import 'package:get_it/get_it.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_from_friendProfile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/friend_list_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/home_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/user_profile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_invite_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/services/comment/comment_service.dart';
import 'package:zamongcampus/src/services/comment/comment_service_fake.dart';
import 'package:zamongcampus/src/services/comment/comment_service_implementation.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';
import 'package:zamongcampus/src/services/friend/friend_service_fake.dart';
import 'package:zamongcampus/src/services/friend/friend_service_implementation.dart';
import 'package:zamongcampus/src/services/interest/interest_service.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';
import 'package:zamongcampus/src/services/login/login_service_fake.dart';
import 'package:zamongcampus/src/services/login/login_service_implementation.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/services/post/post_service_fake.dart';
import 'package:zamongcampus/src/services/post/post_service_implementation.dart';
import 'package:zamongcampus/src/services/report/report_service.dart';
import 'package:zamongcampus/src/services/report/report_service_fake.dart';
import 'package:zamongcampus/src/services/report/report_service_implementation.dart';
import 'package:zamongcampus/src/services/signup/signup_service.dart';
import 'package:zamongcampus/src/services/signup/signup_service_fake.dart';
import 'package:zamongcampus/src/services/signup/signup_service_implementation.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/services/user/user_service_fake.dart';
import 'package:zamongcampus/src/services/user/user_service_implementation.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';
import 'package:zamongcampus/src/services/voice/voice_service_implementation.dart';

import '../business_logic/view_models/post_main_screen_viewmodel.dart';
import '../services/chat/chat_service.dart';
import '../services/chat/chat_service_implementation.dart';
import '../services/interest/interest_service_implementation.dart';
import '../services/voice/voice_service_fake.dart';

/** GetIt: service Locator **/
GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  /* services */
  /* 1. 실제 가능한 services */
  // serviceLocator.registerLazySingleton<LoginService>(() => FakeLoginService());
  // serviceLocator.registerLazySingleton<PostService>(() => FakePostService());
  // serviceLocator
  //     .registerLazySingleton<CommentService>(() => FakeCommentService());
  // serviceLocator
  //     .registerLazySingleton<FriendService>(() => FakeFriendService());
  // serviceLocator
  //     .registerLazySingleton<SignUpService>(() => FakeSignUpService());
  // serviceLocator.registerLazySingleton<VoiceService>(() => FakeVoiceService());
  // serviceLocator.registerLazySingleton<UserService>(() => FakeUserService());
  // serviceLocator.registerLazySingleton<ReportService>(() => FakeReportService());

  /* 2. 실제 불가능한 services */
  serviceLocator.registerLazySingleton<ChatService>(() => ChatServiceImpl());
  serviceLocator
      .registerLazySingleton<InterestService>(() => InterestServiceImpl());

  /* 3. 실제 services */
  serviceLocator.registerLazySingleton<LoginService>(() => LoginServiceImpl());
  serviceLocator.registerLazySingleton<PostService>(() => PostServiceImpl());
  serviceLocator
      .registerLazySingleton<CommentService>(() => CommentServiceImpl());
  serviceLocator
      .registerLazySingleton<FriendService>(() => FriendServiceImpl());
  serviceLocator.registerLazySingleton<VoiceService>(() => VoiceServiceImpl());
  serviceLocator
      .registerLazySingleton<SignUpService>(() => SignUpServiceImpl());
  serviceLocator.registerLazySingleton<UserService>(() => UserServiceImpl());
  serviceLocator
      .registerLazySingleton<ReportService>(() => ReportServiceImpl());

  /* view models */
  serviceLocator.registerFactory(() => LoginMainScreenViewModel());
  serviceLocator.registerLazySingleton<PostMainScreenViewModel>(
      () => PostMainScreenViewModel());
  serviceLocator.registerFactory<PostCreateScreenViewModel>(
      () => PostCreateScreenViewModel());
  serviceLocator.registerLazySingleton<VoiceMainScreenViewModel>(
      () => VoiceMainScreenViewModel());
  serviceLocator.registerLazySingleton<ChatViewModel>(() => ChatViewModel());
  serviceLocator
      .registerLazySingleton<ChatDetailViewModel>(() => ChatDetailViewModel());
  serviceLocator.registerLazySingleton<ChatDetailFromFriendProfileViewModel>(
      () => ChatDetailFromFriendProfileViewModel());
  serviceLocator.registerLazySingleton<PostDetailScreenViewModel>(
      () => PostDetailScreenViewModel());
  serviceLocator.registerLazySingleton<VoiceCreateViewModel>(
      () => VoiceCreateViewModel());
  serviceLocator.registerLazySingleton<VoiceInviteViewModel>(
      () => VoiceInviteViewModel());
  serviceLocator.registerLazySingleton<VoiceDetailViewModel>(
      () => VoiceDetailViewModel());
  serviceLocator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  serviceLocator.registerLazySingleton<UserProfileViewModel>(
      () => UserProfileViewModel());
  serviceLocator
      .registerLazySingleton<MypageViewModel>(() => MypageViewModel());
  serviceLocator
      .registerFactory<FriendListViewModel>(() => FriendListViewModel());
  serviceLocator
      .registerLazySingleton<SignUpViewModel>(() => SignUpViewModel());
  serviceLocator.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
}
