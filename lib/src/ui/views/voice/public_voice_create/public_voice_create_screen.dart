import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/sub_appbar_components/sub_appbar.dart';

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
              appBar: SubAppbar(
                titleText: '공개 대화방 만들기',
              ),
              backgroundColor: Colors.white,
              body: Body(vm: vm),
            ),
          );
        }));
  }
}
