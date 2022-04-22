import 'package:get_it/get_it.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/auth/auth_service.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';
import 'package:zamongcampus/src/services/friend/friend_service_fake.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';
import 'package:zamongcampus/src/services/login/login_service_fake.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/services/post/post_service_fake.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/services/user/user_service_fake.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

import '../business_logic/view_models/post_main_screen_viewmodel.dart';
import '../services/voice/voice_service_fake.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  // services
  serviceLocator.registerLazySingleton<PostService>(() => FakePostService());
  serviceLocator.registerLazySingleton<VoiceService>(() => FakeVoiceService());
  serviceLocator.registerLazySingleton<UserService>(() => FakeUserService());
  serviceLocator.registerLazySingleton<LoginService>(() => FakeLoginService());
  serviceLocator
      .registerLazySingleton<FriendService>(() => FakeFriendService());
  // You can replace the actual services above with fake implementations during development.
  //
  // serviceLocator.registerLazySingleton<PostService>(() => PostServiceImpl());

  // view models
  serviceLocator.registerFactory(() => AuthService());
  serviceLocator.registerFactory(() => LoginMainScreenViewModel());
  serviceLocator.registerFactory<PostMainScreenViewModel>(
      () => PostMainScreenViewModel());
  serviceLocator.registerFactory<VoiceMainScreenViewModel>(
      () => VoiceMainScreenViewModel());
  serviceLocator.registerFactory<VoiceFriendFormScreenViewModel>(
      () => VoiceFriendFormScreenViewModel());
  serviceLocator.registerFactory<PostDetailScreenViewModel>(
      () => PostDetailScreenViewModel());
  serviceLocator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  serviceLocator
      .registerLazySingleton<MypageViewModel>(() => MypageViewModel());
}
