import 'package:flutter/material.dart';
import 'package:zamongcampus/src/ui/dummy_screen.dart';
import 'package:zamongcampus/src/ui/views/home.dart';
import 'package:zamongcampus/src/ui/views/login/login_main/login_main_screen.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_comment/mypage_comment_screen.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_info/mypage_edit_info_screen.dart';
import 'package:zamongcampus/src/ui/views/mypage/mypage_edit_interest/mypage_edit_interest_screen.dart';
import 'package:zamongcampus/src/ui/views/mypage/settings/components/inquiry/inquiry_page.dart';
import 'package:zamongcampus/src/ui/views/mypage/settings/settings_screen.dart';
import 'package:zamongcampus/src/ui/views/error.dart';
import 'package:zamongcampus/src/ui/views/notification/notification_main/notification_main_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_account/signup_account_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_authentication/signup_authentication_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/signup_college_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_interest/signup_interest_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_optional_profile/signup_optional_profile_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_request_major/signup_request_major_screen.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_required_profile/signup_required_profile_screen.dart';
import 'package:zamongcampus/src/ui/views/post/post_create/post_create_screen.dart';
import 'package:zamongcampus/src/ui/views/splash.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => const Home(),
  "/login": (BuildContext context) => const LoginMainScreen(),
  "/mypageEditInfo": (BuildContext context) => const MypageEditInfoScreen(),
  "/mypageEditInterest": (BuildContext context) =>
      const MypageEditInterestScreen(),
  "/settings": (BuildContext context) => const SettingsScreen(),
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
  "/signUpInterest": (BuildContext context) => const SignUpInterestScreen(),
  "/dummy": (BuildContext context) => DummyScreen(),
  "/postCreate": (BuildContext context) => const PostCreateScreen(),
  "/mypageComment": (BuildContext context) => const MypageCommentScreen(),
  "/notification": (BuildContext context) => const NotificationMainScreen(),
  "/signUpRequestMajor": (BuildContext context) =>
      const SignUpRequestMajorScreen(),
      "/inquiry": (BuildContext context) => const InquiryPage(),
};
