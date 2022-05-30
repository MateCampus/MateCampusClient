import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/business_logic/utils/category_data.dart';

enum VoiceRoomType { PUBLIC, PRIVATE }

class VoiceRoom {
  final int id;
  final String title;
  String? roomId;
  String? token;
  int? uid;
  String? ownerLoginId;
  List<dynamic>? userImageUrls;
  List<dynamic>? memberInfos;
  // DateTime createdAt;
  //VoiceRoomType? type;
  List<Category>? categories;
  //bool? collegeOnly;
  //bool? majorOnly;

  VoiceRoom({
    required this.id,
    required this.title,
    this.roomId,
    this.token,
    this.uid,
    this.ownerLoginId,
    this.userImageUrls,
    this.memberInfos,
    this.categories,
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
                ?.map((member) => ChatMemberInfo.fromJson(member))
                .toList(),
            categories: json['categories']?.toList(),
            //createdAt: DateTime?.parse(json['createdAt']),
            // type: VoiceRoomType.values.byName(json['type']),
            // collegeOnly: json['collegeOnly'],
            // majorOnly: json['majorOnly']
          )
        : VoiceRoom(
            id: json['id'],
            title: json['title'],
            userImageUrls: json['userImageUrls'].toList(),
            //createdAt: DateTime?.parse(json['createdAt']),
          );
  }
}
