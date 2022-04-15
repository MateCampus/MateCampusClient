import 'package:zamongcampus/src/business_logic/models/user.dart';
import 'package:zamongcampus/src/config/dummy_data.dart';
import 'package:zamongcampus/src/services/friend/friend_service.dart';

class FakeFriendService implements FriendService {
  @override
  Future<List<User>> fetchFriendUsers() async {
    //옮기는중
    List<User> list = [];
    list.addAll(userDummy);
    return list;
  }
}
