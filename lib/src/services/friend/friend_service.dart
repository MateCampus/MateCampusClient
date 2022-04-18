import 'package:zamongcampus/src/business_logic/models/user.dart';

abstract class FriendService {
  Future<List<User>> fetchFriendUsers();
}
