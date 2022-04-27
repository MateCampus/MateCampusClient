import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';

class FakeFriendService implements FriendService {
  // FriendRequestStatus ACCEPTED 유저 패치
  @override
  Future<List<User>> fetchFriendUsers() async {
    List<User> list = [];
    list.addAll(userDummy2);
    return list;
  }

  //내가 친구신청한 유저 패치
  @override
  Future<List<User>> fetchWaitingUsers() async {
    List<User> list = [];
    list.addAll(userDummy3);
    return list;
  }

  //나에게 친구신청한 유저 패치
  @override
  Future<List<User>> fetchRequestUsers() async {
    List<User> list = [];
    list.addAll(userDummy);
    return list;
  }
}
