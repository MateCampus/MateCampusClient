import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_detail_viewmodel.dart';
import 'package:zamongcampus/src/config/service_locator.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/voice/voice_detail/components/body.dart';
import 'components/body.dart';

class VoiceDetailScreen extends StatefulWidget {
  static const routeName = '/voiceDetail';
  int? id;
  VoiceRoom? voiceRoom;
  VoiceDetailScreen({Key? key, required this.id, this.voiceRoom})
      : super(key: key);

  @override
  _VoiceDetailScreenState createState() => _VoiceDetailScreenState();
}

class _VoiceDetailScreenState extends State<VoiceDetailScreen> {
  VoiceDetailViewModel vm = serviceLocator<VoiceDetailViewModel>();

  @override
  void initState() {
    vm.voiceDetailInit(id: widget.id, createdVoiceRoom: widget.voiceRoom);
    super.initState();
  }

  @override
  void dispose() {
    print('dispose voice detail');
    vm.resetData();
    serviceLocator.resetLazySingleton<VoiceDetailViewModel>(instance: vm);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context: context);
    return ChangeNotifierProvider.value(
      value: vm,
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
                    Navigator.pop(context);
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person_add_outlined),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.logout_outlined),
                    color: Colors.black,
                  ),
                ],
                elevation: 0.0,
                backgroundColor: screenBackgroundColor,
              ),
              backgroundColor: screenBackgroundColor,
              body: vm.busy ? const IsLoading() : Body(vm: vm),
            ),
          ),
        );
      })),
    );
  }
}
