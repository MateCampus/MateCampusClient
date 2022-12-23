import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'enums/collegeCode.dart';
import 'enums/interestCode.dart';

class User {
  final int? id;
  final String loginId;
  final String nickname;
  final String? imageUrl;
  final CollegeCode? collegeCode;
  final String? majorName;
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
    this.majorName,
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
        collegeCode: json['collegeCode'] != null
            ? CollegeCode.values.byName(json['collegeCode'].toLowerCase())
            : null,
        majorName: (json['majorCode'] != null)
            ? json['majorCode']
            : null,
        name: json['name'],
        deviceToken: json['deviceToken'],
        password: json['password'],
        isOnline: json['online'], // boolean은 is빼고 서버에서 넘어옴.
        introduction: json['introduction'],
        interests: json['interests']
            ?.map<Interest>((interestCode) => Interest(
                codeNum: InterestCode.values
                    .byName(interestCode["interestCode"].toLowerCase())))
            .toList(),
        interestCount: json['interestCount'],
        friendCount: json['friendCount'],
        bookMarkCount: json['bookMarkCount'],
        myPostCount: json['myPostCount'],
        myCommentCount: json['myCommentCount'],
        );
  }
}
