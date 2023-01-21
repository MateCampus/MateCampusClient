import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/interest.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';

import '../../business_logic/models/enums/interestCode.dart';
import '../../business_logic/utils/https_client.dart';
import 'interest_service.dart';
import 'dart:convert';

class InterestServiceImpl extends InterestService {
  var client = HttpsClient.client;
  @override
  Future<List<Interest>> fetchMyInterests() async {
    // TODO: implement fetchMyInterests
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    final response = await client.get(Uri.parse(devServer + "/api/interest/my"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken));
    if (response.statusCode == 200) {
      List<Interest> interests =
          await jsonDecode(utf8.decode(response.bodyBytes))
              .map<Interest>((json) => Interest.fromJson(json))
              .toList();
      return interests;
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return fetchMyInterests();
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('관심사 가져오기 실패'); // TODO : 이 오류가 생기면 앱 자체를 새로 load하는 모듈 필요
    }
  }

  @override
  Future<List<Interest>> updateMyInterests(
      List<InterestCode> selectInterestCodes) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    var json = jsonEncode(selectInterestCodes
        .map((code) => {"interestCode": code.name.toUpperCase()})
        .toList());
    final response = await client.put(
        Uri.parse(devServer + "/api/userInterest/my"),
        headers: AuthService.get_auth_header(
            accessToken: accessToken, refreshToken: refreshToken),
        body: json);

    if (response.statusCode == 200) {
      return await jsonDecode(utf8.decode(response.bodyBytes))
          .map<Interest>((json) => Interest.fromJson(json))
          .toList();
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return updateMyInterests(selectInterestCodes);
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      throw Exception('updateMyInterests 서버 오류');
    }
  }
}
