import 'package:zamongcampus/src/business_logic/models/interest.dart';

import '../../business_logic/models/enums/interestCode.dart';
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
