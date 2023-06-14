import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/models/enums/workType.dart';
import 'package:zamongcampus/src/business_logic/models/enums/functionType.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/object/secure_storage_object.dart';
import 'package:zamongcampus/src/services/login/login_service.dart';
import 'package:zamongcampus/src/services/statistics/work_history_service.dart';
import 'package:http/http.dart' as http;

class WorkHistoryServiceImpl extends WorkHistoryService {
  @override
  Future<void> sendWorkHistory(
      {required WorkType workType, required FunctionType functionType}) async {
    String? accessToken = await SecureStorageObject.getAccessToken();
    String? refreshToken = await SecureStorageObject.getRefreshToken();
    var request =
        http.MultipartRequest("POST", Uri.parse(devServer + "/work-history"))
          ..headers.addAll(AuthService.get_auth_header(
              accessToken: accessToken, refreshToken: refreshToken));
    request.fields['workType'] = workType.name;
    request.fields['functionType'] = functionType.name;

    var response = await request.send();
    if (response.statusCode == 200) {
      print(
          workType.name + "\t" + functionType.name + "\twork history send 성공");
    } else if (response.statusCode == 401) {
      LoginService loginService = serviceLocator<LoginService>();
      await loginService.reissueToken();
      print('토큰재발행 완료');
      return sendWorkHistory(workType: workType, functionType: functionType);
    } else {
      throw Exception('work history 서버 오류');
    }
  }
}
