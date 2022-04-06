import 'package:zamongcampus/src/business_logic/models/chatRoomMemberInfo.dart';

import '../../../object/sqflite_object.dart';

const String tableName = 'ChatRoomMemberInfo';
const String columnrowId = 'rowId';
const String columnroomId = 'roomId';
const String columnloginId = 'loginId';

class ChatRoomMemberInfoDB {
  // CREATE : params로 chatmemberInfo를 받음(놓치지말 것)
  // TODO: update 후, 안되면 insert (22.04.01)
  Future<void> insertChatRoomMemberInfo(
      List<ChatRoomMemberInfo> chatRoomMemberInfos) async {
    final db = await SqfliteObject.database;

    if (chatRoomMemberInfos.isEmpty) return;
    for (var chatRoomMemberInfo in chatRoomMemberInfos) {
      await db!.rawInsert(
          'INSERT INTO $tableName(rowId,roomId,loginId) VALUES(?,?,?)',
          [null, chatRoomMemberInfo.roomId, chatRoomMemberInfo.loginId]);
    }
  }

  Future<void> insertChatRoomMemberInfoOne(
      ChatRoomMemberInfo chatRoomMemberInfo) async {
    final db = await SqfliteObject.database;

    await db!.rawInsert(
        'INSERT INTO $tableName(rowId,roomId,loginId) VALUES(?,?,?)',
        [null, chatRoomMemberInfo.roomId, chatRoomMemberInfo.loginId]);
  }

  // DELETE: 1개 삭제
  void deleteChatRoomMemberInfo(String roomId, String loginId) async {
    final db = await SqfliteObject.database;
    List res = await db!.rawQuery(
        'DELETE FROM $tableName WHERE roomId = ?, loginId = ?',
        [roomId, loginId]);
    print(res);
  }

  // DELETE: 전체 방 member 삭제
  void deleteChatRoomMemberInfoByRoomId(String roomId) async {
    final db = await SqfliteObject.database;
    List res =
        await db!.rawQuery('DELETE FROM $tableName WHERE roomId = ?', [roomId]);
    print(res);
  }

  // EXIST
  Future<bool> isExistChatRoomMemberInfo(String loginId) async {
    final db = await SqfliteObject.database;
    List res = await db!
        .rawQuery('SELECT roomId FROM $tableName WHERE loginId = ?', [loginId]);
    print(res.length);
    return res.isNotEmpty ? true : false;
  }

  // --- 여기 아래 부터는 테스트를 위해 존재함.
  // READ: 모든 데이터 읽기
  Future<List<ChatRoomMemberInfo>> getAllChatRoomMemberInfos() async {
    final db = await SqfliteObject.database;
    List res = await db!
        .rawQuery('SELECT roomId, loginId FROM $tableName ORDER BY rowId');
    List<ChatRoomMemberInfo> chatRoomMemberInfos = res.isNotEmpty
        ? res.map((c) => ChatRoomMemberInfo.fromJson(c)).toList()
        : [];

    return chatRoomMemberInfos;
  }

  // DELETE: 모든 중간 테이블 삭제
  void deleteAllChatRoomMemberInfo() async {
    final db = await SqfliteObject.database;
    db!.delete(tableName);
    print("모든 멤버 정보 삭제");
  }
}
