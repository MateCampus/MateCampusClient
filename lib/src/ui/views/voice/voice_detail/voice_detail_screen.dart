import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zamongcampus/src/business_logic/arguments/voice_invite_friend_screen_args.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/models/voice_room.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
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
    vm.voiceDetailInit(
        id: widget.id, createdVoiceRoom: widget.voiceRoom, context: context);
    super.initState();
  }

  @override
  void dispose() {
    print('dispose voice detail');
    //TODO: 여기 나중에 주석풀어야함
    // vm.resetData();
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
          child: Scaffold(
            //PreferredSize => Appbar 크기를 줄여서 body에 더 많은 내용을 보여주기 위함
            appBar: PreferredSize(
              preferredSize: Size(
                  SizeConfig.screenWidth!, getProportionateScreenHeight(45)),
              child: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.expand_more_outlined),
                  color: Colors.black,
                  iconSize: kAppBarIconSizeG,
                  onPressed: () {
                    Navigator.pop(context);
                    vm.removeVoiceFilterOverlay();
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      if (vm.voiceRoomMembers.length == 8) {
                        buildDialogForNotice(
                            context: context,
                            description: '인원을 초과하여 초대할 수 없습니다');
                      } else {
                        Navigator.pushNamed(context, "/voiceInviteFriend",
                            arguments:
                                VoiceInviteFriendScreenArgs(vm.voiceRoom.id));
                      }
                    },
                    icon: const Icon(Icons.person_add_outlined),
                    color: Colors.black,
                    iconSize: kAppBarIconSizeG,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      vm.removeVoiceFilterOverlay();
                    },
                    icon: const Icon(Icons.logout_outlined),
                    color: Colors.black,
                    iconSize: kAppBarIconSizeG,
                  ),
                ],
                elevation: 0.0,
                backgroundColor: kSubScreenBackgroundColor,
              ),
            ),
            backgroundColor: kSubScreenBackgroundColor,
            body: vm.busy ? const IsLoading() : Body(vm: vm),
          ),
        );
      })),
    );
  }
}
