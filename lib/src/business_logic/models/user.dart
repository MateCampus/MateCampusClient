import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';

class User {
  final int? id;
  final String loginId;
  final String nickname;
  final String? imageUrl;
  final College? collegeCode;
  final Major? majorCode;
  final String? name;
  final String? deviceToken;
  final String? password;
  final bool? isOnline;
  final String? introduction;
  final List<Interest>? interests;
  final int? interestCount;
  final int? friendCount;
  final int? bookMarkCount;
  final int? myPostCount;
  final int? myCommentCount;

  const User({
    this.id,
    required this.loginId,
    required this.nickname,
    this.imageUrl,
    this.collegeCode,
    this.majorCode,
    this.name,
    this.deviceToken,
    this.password,
    this.isOnline,
    this.introduction,
    this.interests,
    this.interestCount,
    this.friendCount,
    this.bookMarkCount,
    this.myPostCount,
    this.myCommentCount,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        loginId: json['loginId'],
        nickname: json['nickname'],
        imageUrl: json['imageUrl'],
        collegeCode: College.values.byName(json['collegeCode'].toLowerCase()),
        majorCode: Major.values.byName(json['majorCode'].toLowerCase()),
        name: json['name'],
        deviceToken: json['deviceToken'],
        password: json['password'],
        isOnline: json['isOnline'],
        introduction: json['introduction'],
        interests: json['interests'],
        interestCount: json['interestCount'],
        friendCount: json['friendCount'],
        bookMarkCount: json['bookMarkCount'],
        myPostCount: json['myPostCount'],
        myCommentCount: json['myCommentCount']);
  }
}
