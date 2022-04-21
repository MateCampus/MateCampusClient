import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/voice/private_voice_create/components/body.dart';

class PrivateVoiceCreateScreen extends StatefulWidget {
  const PrivateVoiceCreateScreen({Key? key}) : super(key: key);

  @override
  State<PrivateVoiceCreateScreen> createState() =>
      _PrivateVoiceCreateScreenState();
}

class _PrivateVoiceCreateScreenState extends State<PrivateVoiceCreateScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
      child: Scaffold(
        appBar: AppBar(
          title: const Text('비밀 대화방 만들기',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_outlined),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: const Body(),
      ),
    );
  }
}
