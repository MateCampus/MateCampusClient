import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/init/auth_service.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/object/info_object.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';

class InquiryPage extends StatefulWidget {
  const InquiryPage({ Key? key }) : super(key: key);

  @override
  State<InquiryPage> createState() => _InquiryPageState();
}

class _InquiryPageState extends State<InquiryPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return Scaffold(
      appBar: SubAppbar(
        titleText: '문의하기',
        isCenter: true,
      ),
      backgroundColor: Colors.white,
      body: _inquiryText(),
    );
  }

  Widget _inquiryText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VerticalSpacing(),
          RichText(
              text: TextSpan(
                  text: '문의사항',
                  style: TextStyle(
                    fontSize: resizeFont(26),
                    fontWeight: FontWeight.w500,
                    color: kMainColor,
                  ),
                  children: [
                TextSpan(
                    text: '은\n아래 메일로 문의해주세요!',
                    style: TextStyle(
                        fontSize: resizeFont(22),
                        color: Color(0xff111111),
                        fontWeight: FontWeight.w500))
              ])),
          VerticalSpacing(of: 10),
          Text(
            '문의에 대한 답변은 24시간 내로 받아 보실 수 있습니다.',
            style:
                TextStyle(fontSize: resizeFont(14), color: Color(0xff767676)),
          ),
          VerticalSpacing(of: 10),
          TextButton(
            onPressed: () {
              InfoObject.getDeviceVersion();
              _sendEmail(context);
            },
            child: const Text('mate221207@gmail.com'),
            style: TextButton.styleFrom(
                textStyle: TextStyle(
                    fontSize: resizeFont(16),
                    decoration: TextDecoration.underline)),
          )
        ],
      ),
    );
  }

  void _sendEmail(context) async {
    String version = await InfoObject.getDeviceVersion();
    // String deviceSystem = await InfoObject.getDeviceName();
    //이메일 body추가
    String body = "";

    body += "==============\n";
    body += "아래 내용을 함께 보내주시면 큰 도움이 됩니다 \u{1F34A}";
    body += "\n아이디 : " + AuthService.loginId.toString();
    body += "\nOS 버전 : " + version;
    body += "\n==============\n";

    final Email email = Email(
      body: body,
      subject: '[자몽캠퍼스 문의]',
      recipients: ['mate221207@gmail.com'],
      cc: [],
      bcc: [],
      attachmentPaths: [],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      String message =
          "기본 메일 앱을 사용하지 않는 기기입니다.이 경우에 자몽캠퍼스에서 바로 문의메일을 전송할 수 없습니다.\n\n아래 이메일로 직접 연락주시면 친절하게 답변해드릴게요 :)\n\nmate221207@gmail.com";
      buildDialogForNotice(context: context, description: message);
    }
  }
}