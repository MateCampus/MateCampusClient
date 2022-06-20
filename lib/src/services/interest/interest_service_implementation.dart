import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';

import '../../business_logic/models/enums/interestCode.dart';
import 'interest_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InterestServiceImpl extends InterestService {
  @override
  Future<List<Interest>> fetchMyInterests() async {
    // TODO: implement fetchMyInterests
    final response = await http.get(Uri.parse(devServer + "/api/interest/my"),
        headers: AuthService.get_auth_header());
    if (response.statusCode == 200) {
      List<Interest> interests =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<Interest>((json) => Interest.fromJson(json))
              .toList();
      return interests;
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('관심사 가져오기 실패'); // TODO : 이 오류가 생기면 앱 자체를 새로 load하는 모듈 필요
    }
  }

  @override
  Future<List<Interest>> updateMyInterests(
      List<InterestCode> selectInterestCodes) async {
    var json = jsonEncode(selectInterestCodes
        .map((code) => {"interestCode": code.name.toUpperCase()})
        .toList());
    final response = await http.put(
        Uri.parse(devServer + "/api/userInterest/my"),
        headers: AuthService.get_auth_header(),
        body: json);

    if (response.statusCode == 200) {
      return await jsonDecode(utf8.decode(response.bodyBytes))
          .map<Interest>((json) => Interest.fromJson(json))
          .toList();
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('오류');
    }
  }
}
