import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'package:zamongcampus/src/ui/views/voice/public_voice_create/components/body.dart';

class PublicVoiceCreateScreen extends StatefulWidget {
  const PublicVoiceCreateScreen({Key? key}) : super(key: key);

  @override
  State<PublicVoiceCreateScreen> createState() => _PublicVoiceCreateState();
}

class _PublicVoiceCreateState extends State<PublicVoiceCreateScreen> {
  VoiceCreateViewModel vm = serviceLocator<VoiceCreateViewModel>();
  @override
  void initState() {
    vm.setPublicVoiceRoom();
    super.initState();
  }

  @override
  void dispose() {
    serviceLocator.resetLazySingleton<VoiceCreateViewModel>(instance: vm);
    print('dispose public voice create');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);

    return ChangeNotifierProvider<VoiceCreateViewModel>.value(
        value: vm,
        child: Consumer<VoiceCreateViewModel>(builder: (context, vm, child) {
          return GestureDetector(
            onTap: () =>
                FocusScope.of(context).unfocus(), //키보드 외부 영역 터치 시 키보드 내려감
            child: Scaffold(
              appBar: AppBar(
                title: const Text('공개 대화방 만들기',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
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
              body: Body(vm: vm),
            ),
          );
        }));
  }
}
