import 'package:zamongcampus/src/business_logic/utils/college_data.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';

import 'interest.dart';

class Friend {
  final int id;
  final String loginId;
  final String nickname;
  final String requestorLoginId;
  final FriendRequestStatus friendRequestStatus;
  final String? imageUrl;
  final College? collegeCode;
  final Major? majorCode;
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
      this.majorCode,
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
          ? College.values.byName(json['collegeCode'].toLowerCase())
          : null,
      majorCode: json['majorCode'] != null
          ? Major.values.byName(json['majorCode'].toLowerCase())
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

enum FriendRequestStatus { NONE, UNACCEPTED, ACCEPTED, REFUSED }
