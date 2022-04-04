import 'package:flutter/material.dart';

class MainService extends ChangeNotifier {
  static String? deviceToken;
  List<int> likedPostIds = [];
  List<int> bookMarkedPostIds = [];

  // loginId가 바뀔 때, 혹은 로그인할 때 활용하도록.
  // fetchUserData 라고 해놓고 가져오면 될듯?
}
