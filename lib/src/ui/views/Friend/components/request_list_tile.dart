import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/friend_list_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/profile_bottom_sheet.dart';

class RequestListTile extends StatelessWidget {
  final FriendListViewModel vm;
  final FriendPresentation friend;
  const RequestListTile({Key? key, required this.vm, required this.friend})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10)),
      child: InkWell(
        onTap: () {
          showCustomModalBottomSheet(
              context: context,
              buildWidget: ProfileBottomSheet(friendId: friend.id));
        },
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: getProportionateScreenHeight(25),
                backgroundImage: friend.imageUrl.startsWith('https')
                    ? CachedNetworkImageProvider(friend.imageUrl)
                        as ImageProvider
                    : AssetImage(
                        friend.imageUrl,
                      ),
              ),
              /* isOnline 로직 구현 후  */
              // Positioned(
              //   bottom: 1,
              //   right: -1,
              //   child: Container(
              //       width: getProportionateScreenWidth(15),
              //       height: getProportionateScreenHeight(15),
              //       decoration: BoxDecoration(
              //         color: friend.isOnline
              //             ? const Color(0xff00FFBA) //온라인 상태일 때 색
              //             : Colors.grey, //오프라인 상태일 떄 색
              //         shape: BoxShape.circle,
              //         border: Border.all(
              //             color: Colors.white,
              //             width: 3.0,
              //             style: BorderStyle.solid),
              //       )),
              // )
            ],
          ),
          title: Text(
            friend.nickname,
            style: TextStyle(
                fontSize: resizeFont(14),
                color: Colors.black87,
                fontWeight: FontWeight.w500),
          ),
          trailing: Wrap(
            spacing: getProportionateScreenWidth(5),
            children: [
              TextButton(
                onPressed: () {
                  vm.approveRequest(friend);
                },
                child: Text('수락'),
                style: TextButton.styleFrom(
                  backgroundColor: kMainColor,
                  primary: Colors.white,
                ),
              ),
              TextButton(
                  onPressed: () {
                    vm.refuseRequest(friend);
                  },
                  child: Text('거절'),
                  style: TextButton.styleFrom(
                      primary: kMainColor,
                      side: BorderSide(color: kMainColor))),
            ],
          ),
        ),
      ),
    );
  }
}
