import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_friend_form_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';

import 'components/body.dart';

class VoiceFriendFormScreen extends StatefulWidget {
  const VoiceFriendFormScreen({Key? key}) : super(key: key);

  @override
  State<VoiceFriendFormScreen> createState() => _VoiceFriendFormScreenState();
}

class _VoiceFriendFormScreenState extends State<VoiceFriendFormScreen> {
  VoiceFriendFormScreenViewModel vm =
      serviceLocator<VoiceFriendFormScreenViewModel>();
  @override
  void initState() {
    // TODO: implement initState
    vm.loadUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<VoiceFriendFormScreenViewModel>(
        create: (context) => vm,
        child: Consumer<VoiceFriendFormScreenViewModel>(
            builder: (context, model, child) {
          return Scaffold(
              appBar: AppBar(title: Text("추천친구 창")), body: Body(vm: vm));
        }));
  }
}
