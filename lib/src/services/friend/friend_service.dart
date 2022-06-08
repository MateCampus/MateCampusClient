import 'package:zamongcampus/src/business_logic/models/friend.dart';

abstract class FriendService {
  Future<void> requestFriend({required String targetLoginId});
  Future<List<Friend>> fetchFriends();
  Future<Friend> fetchFriend(int friendId);
  Future<List<Friend>> fetchApprovedTypeFriends();
  Future<void> approveFriend({required String targetLoginId});
  Future<void> refuseFriend({required String targetLoginId});
}
