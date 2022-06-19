import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';

enum VoiceRoomType { PUBLIC, PRIVATE }

class VoiceRoom {
  final int id;
  String? title;
  String? roomId;
  String? token;
  int? uid;
  String? ownerLoginId;
  List<String>? userImageUrls;
  List<ChatMemberInfo>? memberInfos;
  bool? isFull;
  // DateTime createdAt;
  //VoiceRoomType? type;
  List<Category>? categories;
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
      this.categories,
      this.isFull
      //required this.createdAt,
      // this.type,
      // this.collegeOnly,
      // this.majorOnly
      });

  factory VoiceRoom.fromJson(Map<String, dynamic> json) {
    return json.containsKey('voiceRoomAndTokenInfo')
        ? VoiceRoom(
            id: json['voiceRoomAndTokenInfo']['id'],
            title: json['voiceRoomAndTokenInfo']['title'],
            roomId: json['voiceRoomAndTokenInfo']['roomId'],
            token: json['voiceRoomAndTokenInfo']['token'],
            uid: json['voiceRoomAndTokenInfo']['uid'],
            ownerLoginId: json['voiceRoomAndTokenInfo']['ownerLoginId'],
            memberInfos: json['memberInfos']
                ?.map<ChatMemberInfo>(
                    (member) => ChatMemberInfo.fromJson(member))
                .toList(),
            categories: json['categories']?.toList(),
            isFull: json['full']
            //createdAt: DateTime?.parse(json['createdAt']),
            // type: VoiceRoomType.values.byName(json['type']),
            // collegeOnly: json['collegeOnly'],
            // majorOnly: json['majorOnly']
            )
        : VoiceRoom(
            id: json['id'],
            title: json['title'],
            userImageUrls: json['userImageUrls']
                .map<String>((userImageUrl) => userImageUrl.toString())
                .toList(),
            //createdAt: DateTime?.parse(json['createdAt']),
          );
  }
}
