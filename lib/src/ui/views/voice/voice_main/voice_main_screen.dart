import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'components/body.dart';

class VoiceMainScreen extends StatefulWidget {
  const VoiceMainScreen({Key? key}) : super(key: key);

  @override
  State<VoiceMainScreen> createState() => _VoiceMainScreenState();
}

class _VoiceMainScreenState extends State<VoiceMainScreen> {
  VoiceMainScreenViewModel model = serviceLocator<VoiceMainScreenViewModel>();

  @override
  void initState() {
    model.loadVoiceRoom();
    model.loadRecommendUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<VoiceMainScreenViewModel>(
        create: (context) => model,
        child: Consumer<VoiceMainScreenViewModel>(
            builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(title: Text("hi")), body: Body(model: model));
        }));
  }
}
