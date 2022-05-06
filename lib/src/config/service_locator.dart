import 'package:get_it/get_it.dart';
import 'package:zamongcampus/src/business_logic/view_models/friend_list_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/login_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/mypage_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_detail_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/chat_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_create_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_detail_screen_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/profile_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';
import 'package:zamongcampus/src/services/friend/friend_service_fake.dart';
import 'package:zamongcampus/src/services/friend/friend_service_implementation.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';
import 'package:zamongcampus/src/services/login/login_service_fake.dart';
import 'package:zamongcampus/src/services/login/login_service_implementation.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/services/post/post_service_fake.dart';
import 'package:zamongcampus/src/services/post/post_service_implementation.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/services/user/user_service_fake.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

import '../business_logic/view_models/post_main_screen_viewmodel.dart';
import '../services/chat/chat_service.dart';
import '../services/chat/chat_service_implementation.dart';
import '../services/voice/voice_service_fake.dart';

/** GetIt: service Locator 
 * 
*/
GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  /* services */
  // serviceLocator.registerLazySingleton<LoginService>(() => FakeLoginService());
  // serviceLocator.registerLazySingleton<PostService>(() => FakePostService());
  serviceLocator.registerLazySingleton<VoiceService>(() => FakeVoiceService());
  serviceLocator.registerLazySingleton<UserService>(() => FakeUserService());
  // serviceLocator
  //     .registerLazySingleton<FriendService>(() => FakeFriendService());
  serviceLocator.registerLazySingleton<ChatService>(() => ChatServiceImpl());

  /* You can replace the actual services above with fake implementations during development.*/
  /* 아래 impl를 주석하면 위에 fake를 풀어야한다. */
  serviceLocator.registerLazySingleton<LoginService>(() => LoginServiceImpl());
  serviceLocator.registerLazySingleton<PostService>(() => PostServiceImpl());
  serviceLocator
      .registerLazySingleton<FriendService>(() => FriendServiceImpl());

  /* view models */
  serviceLocator.registerFactory(() => LoginMainScreenViewModel());

  serviceLocator.registerFactory<PostMainScreenViewModel>(
      () => PostMainScreenViewModel());
  serviceLocator.registerFactory<PostCreateScreenViewModel>(
      () => PostCreateScreenViewModel());
  serviceLocator.registerLazySingleton<VoiceMainScreenViewModel>(
      () => VoiceMainScreenViewModel());
  serviceLocator.registerLazySingleton<ChatViewModel>(() => ChatViewModel());
  serviceLocator
      .registerLazySingleton<ChatDetailViewModel>(() => ChatDetailViewModel());
  serviceLocator.registerFactory<PostDetailScreenViewModel>(
      () => PostDetailScreenViewModel());

  serviceLocator.registerLazySingleton<VoiceCreateViewModel>(
      () => VoiceCreateViewModel());
  serviceLocator
      .registerFactory<VoiceDetailViewModel>(() => VoiceDetailViewModel());

  serviceLocator.registerFactory<ProfileViewModel>(() => ProfileViewModel());
  serviceLocator
      .registerLazySingleton<MypageViewModel>(() => MypageViewModel());
  serviceLocator
      .registerFactory<FriendListViewModel>(() => FriendListViewModel());
}
