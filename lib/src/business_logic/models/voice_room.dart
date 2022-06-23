import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';

import 'enums/categoryCode.dart';
import 'enums/voiceCategoryCode.dart';

class VoiceRoom {
  final int id;
  String? title;
  String? roomId;
  String? token;
  int? uid;
  String? ownerLoginId;
  List<String?>? userImageUrls; // main에서만 사용
  List<ChatMemberInfo>? memberInfos;
  bool? isFull;
  // DateTime createdAt;
  //VoiceRoomType? type;
  List<VoiceCategoryCode>? voiceCategoryCodes;
  //bool? collegeOnly;
  //bool? majorOnly;

  VoiceRoom(
      {required this.id,
      this.title,
      this.roomId,
      this.token,
      this.uid,
      this.ownerLoginId,
      this.userImageUrls,
      this.memberInfos,
      this.voiceCategoryCodes,
      this.isFull
      //required this.createdAt,
      // this.type,
      // this.collegeOnly,
      // this.majorOnly
      });

  factory VoiceRoom.fromJson(Map<String, dynamic> json) {
    return VoiceRoom(
        id: json['id'],
        title: json['title'],
        roomId: json['roomId'],
        token: json['token'],
        uid: json['uid'],
        ownerLoginId: json['ownerLoginId'],
        userImageUrls: json['userImageUrls']
            ?.map<String?>((userImageUrl) => userImageUrl as String?)
            .toList(),
        memberInfos: json['memberInfos']
            ?.map<ChatMemberInfo>((member) => ChatMemberInfo.fromJson(member))
            .toList(),
        voiceCategoryCodes: json['voiceCategoryCodes']
            .map<VoiceCategoryCode>((voiceCategoryCode) => VoiceCategoryCode
                .values
                .byName(voiceCategoryCode.toLowerCase()))
            .toList(),
        isFull: json['full']);
  }
}
