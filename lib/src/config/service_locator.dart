import 'package:get_it/get_it.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/services/post/post_service.dart';
import 'package:zamongcampus/src/services/post/post_service_fake.dart';
import 'package:zamongcampus/src/services/post/post_service_implementation.dart';
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
  // You can replace the actual services above with fake implementations during development.
  //
  // serviceLocator.registerLazySingleton<PostService>(() => PostServiceImpl());

  // view models
  serviceLocator.registerFactory<PostMainScreenViewModel>(
      () => PostMainScreenViewModel());
  serviceLocator.registerFactory<VoiceMainScreenViewModel>(
      () => VoiceMainScreenViewModel());
}
