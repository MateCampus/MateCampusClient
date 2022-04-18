import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';

class User {
  final String loginId;
  final String? password;
  final String nickname;
  final String? studentNum;
  final College? collegeCode;
  final Major? majorCode;
  final String? department;
  final String? name;
  final String? email;
  final String? deviceToken;
  final List<String>? imageUrls;
  final bool? isOnline;
  final String? introduction;

  const User(
      {required this.loginId,
      this.password,
      required this.nickname,
      this.studentNum,
      this.collegeCode,
      this.majorCode,
      this.department,
      this.name,
      this.email,
      this.deviceToken,
      this.imageUrls,
      required this.isOnline,
      this.introduction});
}
