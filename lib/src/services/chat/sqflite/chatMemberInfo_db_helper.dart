import 'package:zamongcampus/src/business_logic/models/chatMemberInfo.dart';
import 'package:zamongcampus/src/object/sqflite_object.dart';

const String tableName = 'ChatMemberInfo';
const String columnrowId = 'rowId';
const String columnloginId = 'loginId';
const String columnnickname = 'nickname';
const String columnimageUrl = 'imageUrl';

class ChatMemberInfoDBHelper {
  // TODO: 한번에 값 넣는 방식으로 변경할 것. (ref: batch 방법 찾아볼 것) (22.04.01)
  Future<void> insertOrUpdateMemberInfo(
      List<ChatMemberInfo> chatMemberInfoes) async {
    final db = await SqfliteObject.database;
    if (chatMemberInfoes.isEmpty) return null;
    for (ChatMemberInfo chatMemberInfo in chatMemberInfoes) {
      // update 해보고, 없는 데이터면 insert하도록 구현
      await db?.rawInsert(
          'INSERT OR REPLACE INTO  $tableName(rowId,loginId, nickname, imageUrl) VALUES(?,?,?,?)',
          [
            null,
            chatMemberInfo.loginId,
            chatMemberInfo.nickname,
            chatMemberInfo.imageUrl,
          ]);
    }
  }

  Future<void> insertOrUpdateMemberInfoOne(
      ChatMemberInfo chatMemberInfo) async {
    final db = await SqfliteObject.database;
    await db?.rawInsert(
        'INSERT OR REPLACE INTO  $tableName(rowId,loginId, nickname, imageUrl) VALUES(?,?,?,?)',
        [
          null,
          chatMemberInfo.loginId,
          chatMemberInfo.nickname,
          chatMemberInfo.imageUrl,
        ]);
  }

  // READ: roomId에 해당되는 멤버 값 가져오기(중간테이블 활용)
  Future<List<ChatMemberInfo>> getMemberInfoes(String roomId) async {
    final db = await SqfliteObject.database;
    List res = await db!.rawQuery(
        'SELECT M.loginId, M.nickname, M.imageUrl FROM ChatMemberInfo M INNER JOIN ChatRoomMemberInfo CM ON M.loginId = CM.loginId INNER JOIN ChatRoom C ON CM.roomId = C.roomId AND C.roomId = ?',
        [roomId]);

    List<ChatMemberInfo> memberInfoes =
        res.isEmpty ? [] : res.map((c) => ChatMemberInfo.fromJson(c)).toList();
    return memberInfoes;
  }

  // READ: 전체 다 가져오는 식
  Future<List<ChatMemberInfo>> getAllMemberInfoes() async {
    final db = await SqfliteObject.database;
    List res = await db!
        .rawQuery('SELECT loginId, nickname, imageUrl FROM ChatMemberInfo');
    List<ChatMemberInfo> memberInfoes =
        res.isEmpty ? [] : res.map((c) => ChatMemberInfo.fromJson(c)).toList();
    return memberInfoes;
  }

  // DELETE: loginId에 해당되는 멤버 삭제
  void deleteMemberInfo(String loginId) async {
    final db = await SqfliteObject.database;
    List res = await db!
        .rawQuery('DELETE FROM $tableName WHERE loginId = ?', [loginId]);
    print(res);
  }

  // DELETE: 모든 멤버 삭제
  void deleteAllMemberInfo() async {
    final db = await SqfliteObject.database;
    db!.delete(tableName);
    print("모든 멤버 정보 삭제");
  }
}
