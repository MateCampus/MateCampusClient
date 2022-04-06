import 'package:zamongcampus/src/business_logic/models/chatRoom.dart';
import 'package:zamongcampus/src/object/sqflite_object.dart';

const String tableName = 'ChatRoom';
const String columnRowId = 'rowId';
const String columnRoomId = 'roomId';
const String columnTitle = 'title';
const String columnType = 'type';
const String columnlastMessage = 'lastMessage';
const String columnlastMsgCreatedAt = 'lastMsgCreatedAt';
const String columnImageUrl = 'imageUrl';
const String columnUnreadCount = 'unreadCount';

class ChatRoomDB {
  // CREATE
  Future<int?> insertChatRoom(ChatRoom chatRoom) async {
    final db = await SqfliteObject.database;
    int? res = await db?.rawInsert(
        'INSERT INTO $tableName(rowId, roomId, title, type, lastMessage, lastMsgCreatedAt, imageUrl, unreadCount) VALUES(?,?,?,?,?,?,?,?)',
        [
          null,
          chatRoom.roomId,
          chatRoom.title,
          chatRoom.type,
          chatRoom.lastMessage,
          chatRoom.lastMsgCreatedAt.toString(),
          chatRoom.imageUrl,
          chatRoom.unreadCount
        ]);
    return res;
  }

  // READ: 모든 채팅방
  Future<List<ChatRoom>> getAllChatRooms() async {
    final db = await SqfliteObject.database;
    List res = await db!.rawQuery(
        'SELECT roomId, title, type, lastMessage, lastMsgCreatedAt, imageUrl, unreadCount FROM $tableName ORDER BY lastMsgCreatedAt DESC');
    List<ChatRoom> chatrooms =
        res.isNotEmpty ? res.map((c) => ChatRoom.fromJson(c)).toList() : [];
    return chatrooms;
  }

  // TODO: 용도를 잘 모르겠네? member의 nickname 변경된 방의 title를 바꾸기 위함인가? (22.04.01)
  Future<List<ChatRoom>> getChatRoomsByMemberLoginId(String loginId) async {
    final db = await SqfliteObject.database;
    List res = await db!.rawQuery(
        'SELECT C.roomId, C.type, C.lastMessage, C.lastMsgCreatedAt, C.imageUrl, C.unreadCount FROM ChatRoom C INNER JOIN ChatRoomMemberInfo CM ON C.roomId = CM.roomId INNER JOIN ChatMemberInfo M ON CM.loginId = M.loginId AND M.loginId = ?',
        [loginId]);

    List<ChatRoom> chatRooms =
        res.isNotEmpty ? res.map((c) => ChatRoom.fromJson(c)).toList() : [];
    return chatRooms;
  }

  // DELETE: 채팅방 삭제 (대화방 나갈 때)
  void deleteChatRoomByRoomId(String roomId) async {
    final db = await SqfliteObject.database;
    List res =
        await db!.rawQuery('DELETE FROM $tableName WHERE roomId = ?', [roomId]);
    print(res);
  }

  // DELETE: 모든 채팅방 삭제 (어플 삭제 시, 같이 삭제)
  void deleteAllChatRoom() async {
    final db = await SqfliteObject.database;
    db!.delete(tableName);
    print("모든 채팅방 삭제");
  }

  Future<bool> isExistRoom(String roomId) async {
    final db = await SqfliteObject.database;
    List res = await db!
        .rawQuery('SELECT roomId FROM $tableName WHERE roomId = ?', [roomId]);
    return res.isEmpty ? false : true;
  }

  void updateChatRoom(String lastMsg, DateTime lastMsgCreatedAt,
      int unreadCount, String roomId) async {
    final db = await SqfliteObject.database;
    List res = await db!.rawQuery(
        'UPDATE $tableName SET lastMessage = ?, lastMsgCreatedAt = ?, unreadCount = unreadCount + ? WHERE roomId = ?',
        [lastMsg, lastMsgCreatedAt.toString(), unreadCount, roomId]);
  }

  void updateUnreadCount(int unreadCount, String roomId) async {
    final db = await SqfliteObject.database;
    List res = await db!.rawQuery(
        'UPDATE $tableName SET unreadCount = ? WHERE roomId = ?',
        [unreadCount, roomId]);
  }
}
