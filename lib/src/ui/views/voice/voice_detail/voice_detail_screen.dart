import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/body.dart';

class VoiceDetailScreen extends StatefulWidget {
  static const routeName = '/voiceDetail';
  final int voiceRoomId;
  const VoiceDetailScreen({Key? key, required this.voiceRoomId})
      : super(key: key);

  @override
  _VoiceDetailScreenState createState() => _VoiceDetailScreenState();
}

class _VoiceDetailScreenState extends State<VoiceDetailScreen> {
  VoiceDetailViewModel vm = serviceLocator<VoiceDetailViewModel>();
  @override
  void initState() {
    vm.loadVoiceRoom(widget.voiceRoomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider<VoiceDetailViewModel>(
      create: (context) => vm,
      child: Consumer<VoiceDetailViewModel>(builder: ((context, vm, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: PreferredSize(
            preferredSize: Size.fromHeight(getProportionateScreenHeight(30)),
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.expand_more_outlined),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.of(context).pop(); //일단은 뒤로가기로
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_outlined),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.logout_outlined),
                    color: Colors.black,
                  ),
                ],
                elevation: 0.0,
                backgroundColor: const Color(0xfff8f8f8),
              ),
              backgroundColor: const Color(0xfff8f8f8),
              //extendBodyBehindAppBar: true,
              body: vm.busy ? const IsLoading() : Body(vm: vm),
            ),
          ),
        );
      })),
    );
  }
}
