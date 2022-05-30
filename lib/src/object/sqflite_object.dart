import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteObject {
  static Database? _database;

  // prefs와 비슷하게 만들려다가 일단 뒀음. (4/6)
  static Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initChatRoomsDB();
    print("sqflite init end");
    return _database;
  }

  static Future<void> dropTableIfExistsThenReCreate() async {
    final db = await database;
    await db!.execute("DROP TABLE IF EXISTS ChatRoomMemberInfo"); // ** 디비 삭제.
    await db.execute("DROP TABLE IF EXISTS ChatRoom"); // ** 디비 삭제.
    await db.execute("DROP TABLE IF EXISTS ChatMessage"); // ** 디비 삭제.
    await db.execute("DROP TABLE IF EXISTS ChatMemberInfo"); // ** 디비 삭제.
    await db.execute('''CREATE TABLE IF NOT EXISTS ChatRoom(
          rowId integer primary key autoincrement,
          roomId text not null,
          title text not null,
          type text not null,
          lastMessage text not null,
          lastMsgCreatedAt text not null,
          imageUrl text not null,
          unreadCount integer not null
          )''');
    // chatmessage table
    await db.execute('''CREATE TABLE IF NOT EXISTS ChatMessage(
          rowId integer primary key autoincrement,
          roomId text not null,
          loginId text,
          text text not null,
          type text not null,
          createdAt text not null
          )''');
    // chatRoomMemberInfo table
    await db.execute('''CREATE TABLE IF NOT EXISTS ChatRoomMemberInfo(
          rowId integer primary key autoincrement,
          roomId text not null,
          loginId text not null
          )''');
    // chatmemberInfo table
    await db.execute('''CREATE TABLE IF NOT EXISTS ChatMemberInfo(
          rowId integer primary key autoincrement,
          loginId text not null unique,
          nickname text not null,
          imageUrl text not null
          )''');
    print("table 삭제 후 재 생성");
  }

  // initChatRoomsDB init
  static Future<Database> initChatRoomsDB() async {
    // Chat.db
    String path = join(await getDatabasesPath(), 'Chat.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      // chatmessage table
      await db.execute('''CREATE TABLE IF NOT EXISTS ChatMessage(
          rowId integer primary key autoincrement,
          roomId text not null,
          loginId text,
          text text not null,
          type text not null,
          createdAt text not null
          )''');
      // chatroom table
      await db.execute('''CREATE TABLE IF NOT EXISTS ChatRoom(
          rowId integer primary key autoincrement,
          roomId text not null,
          title text not null,
          type text not null,
          lastMessage text not null,
          lastMsgCreatedAt text not null,
          imageUrl text not null,
          unreadCount integer not null
          )''');
      // chatRoomMemberInfo table
      await db.execute('''CREATE TABLE IF NOT EXISTS ChatRoomMemberInfo(
          rowId integer primary key autoincrement,
          roomId text not null,
          loginId text not null
          )''');
      // chatmemberInfo table
      await db.execute('''CREATE TABLE IF NOT EXISTS ChatMemberInfo(
          rowId integer primary key autoincrement,
          loginId text not null unique,
          nickname text not null,
          imageUrl text not null
          )''');
    }, onUpgrade: (db, oldVersion, newVersion) {});
  }
}
