import 'package:zamongcampus/src/business_logic/models/user.dart';

abstract class FriendService {
  // FriendRequestStatus ACCEPTED 유저 패치
  Future<List<User>> fetchFriendUsers();

  //내가 친구신청한 유저 패치
  Future<List<User>> fetchWaitingUsers();

  //나에게 친구신청한 유저 패치
  Future<List<User>> fetchRequestUsers();
}
