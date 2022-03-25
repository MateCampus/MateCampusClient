import 'package:flutter/material.dart';

import 'package:zamongcampus/src/ui/views/voice/public_voice_create/components/body.dart';

class PublicVoiceCreateScreen extends StatefulWidget {
  const PublicVoiceCreateScreen({Key? key}) : super(key: key);

  @override
  State<PublicVoiceCreateScreen> createState() => _PublicVoiceCreateState();
}

class _PublicVoiceCreateState extends State<PublicVoiceCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
      child: Scaffold(
        appBar: AppBar(
          title: const Text('공개 대화방 만들기',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
