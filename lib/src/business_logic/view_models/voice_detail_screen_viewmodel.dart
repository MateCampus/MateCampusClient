import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/services/user/user_service.dart';
import 'package:zamongcampus/src/services/voice/voice_service.dart';

import 'base_model.dart';

class VoiceDetailScreenViewModel extends BaseModel {
  final VoiceService _voiceService = serviceLocator<VoiceService>();
  final UserService _userService = serviceLocator<UserService>();
}
