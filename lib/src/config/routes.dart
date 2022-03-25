import 'package:flutter/material.dart';
import 'package:zamongcampus/src/ui/views/home.dart';
import 'package:zamongcampus/src/ui/views/login/login_main/login_main_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/private_voice_create/private_voice_create_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/public_voice_create/public_voice_create_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/voice_create_friend_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const Home(),
  "/login": (BuildContext context) => const LoginMainScreen(),
  "/publicVoiceCreate": (BuildContext context) =>
      const PublicVoiceCreateScreen(),
  "/privateVoiceCreate": (BuildContext context) =>
      const PrivateVoiceCreateScreen(),
  "/voiceCreateFriend": (BuildContext context) =>
      const VoiceCreateFriendScreen(),
};
