import 'package:flutter/material.dart';
import 'package:zamongcampus/src/ui/views/Friend/friend_main_screen.dart';
import 'package:zamongcampus/src/ui/views/home.dart';
import 'package:zamongcampus/src/ui/views/login/login_main/login_main_screen.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_info/mypage_edit_info_screen.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/mypage_edit_interest_screen.dart';
import 'package:zamongcampus/src/ui/views/mypage/settings/settings_screen.dart';
import 'package:zamongcampus/src/ui/views/error.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_account/signup_account_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_authentication/signup_authentication_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/signup_college_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_optional_profile/signup_optional_profile_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/signup_default_profile_screen.dart';
import 'package:zamongcampus/src/ui/views/splash.dart';
import 'package:zamongcampus/src/ui/views/voice/private_voice_create/private_voice_create_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/public_voice_create/public_voice_create_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_create_friend/voice_create_friend_screen.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/voice_detail_screen.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const Home(),
  "/login": (BuildContext context) => const LoginMainScreen(),
  "/publicVoiceCreate": (BuildContext context) =>
      const PublicVoiceCreateScreen(),
  "/privateVoiceCreate": (BuildContext context) =>
      const PrivateVoiceCreateScreen(),
  "/voiceCreateFriend": (BuildContext context) =>
      const VoiceCreateFriendScreen(),
  "/mypageEditInfo": (BuildContext context) => const MypageEditInfoScreen(),
  "/mypageEditInterest": (BuildContext context) =>
      const MypageEditInterestScreen(),
  "/settings": (BuildContext context) => const SettingsScreen(),
  "/friend": (BuildContext context) => const FriendMainScreen(),
  "/splash": (BuildContext context) => const SplashScreen(),
  "/error": (BuildContext context) => const ErrorScreen(),
  "/signUpAccount": (BuildContext context) => const SignUpAccountScreen(),
  "/signUpCollege": (BuildContext context) => const SignUpCollegeScreen(),
  "/signUpAuthentication": (BuildContext context) =>
      const SignUpAuthenticationScreen(),
  "/signUpRequiredProfile": (BuildContext context) =>
      const SignUpRequiredProfileScreen(),
  "/signUpOptionalProfile": (BuildContext context) =>
      const SignUpOptionalProfileScreen(),
};
