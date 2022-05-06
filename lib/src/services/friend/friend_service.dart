import 'package:zamongcampus/src/business_logic/models/friend.dart';

abstract class FriendService {
  Future<List<Friend>> fetchFriends();
  Future<List<Friend>> fetchAcceptedTypeFriends();
}
