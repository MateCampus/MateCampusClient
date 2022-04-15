import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';

class User {
  final String loginId;
  final String? password;
  final String userNickname;
  final String? studentNum;
  final College? collegeCode;
  final Major? majorCode;
  final String? department;
  final String? name;
  final String? email;
  final String? deviceToken;
  final List<String>? userImageUrls;
  final bool? isOnline;
  final String? userIntroduction;

  const User(
      {required this.loginId,
      this.password,
      required this.userNickname,
      this.studentNum,
      this.collegeCode,
      this.majorCode,
      this.department,
      this.name,
      this.email,
      this.deviceToken,
      this.userImageUrls,
      required this.isOnline,
      this.userIntroduction});
}
