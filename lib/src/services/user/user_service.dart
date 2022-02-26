import 'package:zamongcampus/src/business_logic/models/user.dart';

abstract class UserService {
  Future<List<User>> fetchRecommendUsers({required int nextPageToken});
}
