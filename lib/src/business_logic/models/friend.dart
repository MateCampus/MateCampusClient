import 'enums/collegeCode.dart';
import 'enums/friendRequestStatus.dart';
import 'enums/interestCode.dart';
import 'interest.dart';

class Friend {
  final int id;
  final String loginId;
  final String nickname;
  final String requestorLoginId;
  final FriendRequestStatus friendRequestStatus;
  final String? imageUrl;
  final CollegeCode? collegeCode;
  final String? majorName;
  final String? introduction;
  final List<Interest>? interests;

  Friend(
      {required this.id,
      required this.loginId,
      required this.nickname,
      required this.requestorLoginId,
      required this.friendRequestStatus,
      this.imageUrl,
      this.collegeCode,
      this.majorName,
      this.introduction,
      this.interests});

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      id: json['id'],
      loginId: json['loginId'],
      nickname: json['nickname'],
      requestorLoginId: json['requestorLoginId'],
      friendRequestStatus: FriendRequestStatus.values.byName(json['status']),
      imageUrl: json['imageUrl'],
      collegeCode: json['collegeCode'] != null
          ? CollegeCode.values.byName(json['collegeCode'].toLowerCase())
          : null,
      majorName: (json['majorCode'] != null)
          ? json['majorCode']
          : null,
      introduction: json['introduction'],
      interests: json['interests']
          ?.map<Interest>((interestCode) => Interest(
              codeNum: InterestCode.values
                  .byName(interestCode["interestCode"].toLowerCase())))
          .toList(),
    );
  }
}
