import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/utils/interest_data.dart';

import 'interest_service.dart';

class FakeInterestService extends InterestService {
  @override
  Future<List<Interest>> fetchMyInterests() {
    // TODO: implement fetchMyInterests
    throw UnimplementedError();
  }

  @override
  Future<List<Interest>> updateMyInterests(
      List<InterestCode> selectInterestCodes) {
    // TODO: implement updateMyInterests
    throw UnimplementedError();
  }
}
