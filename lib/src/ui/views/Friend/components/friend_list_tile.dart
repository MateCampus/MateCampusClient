import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/models/friend.dart';
import 'package:zamongcampus/src/business_logic/utils/methods.dart';
import 'package:zamongcampus/src/business_logic/view_models/friend_list_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_components/profile_bottom_sheet_component/profile_bottom_sheet.dart';

import '../../../../business_logic/models/enums/friendRequestStatus.dart';

class FriendListTile extends StatelessWidget {
  final FriendListViewModel vm;
  final FriendPresentation friend;
  const FriendListTile({Key? key, required this.vm, required this.friend})
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
            contentPadding: EdgeInsets.zero,
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
                /* isOnlined 추후 개발 */
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
            trailing: friend.friendRequestStatus == FriendRequestStatus.ACCEPTED
                ? IconButton(
                    onPressed: () {
                      vm.gotoChatroom(friend.loginId);
                    },
                    icon: const Icon(CupertinoIcons.ellipsis),
                    iconSize: getProportionateScreenWidth(18),
                    color: Colors.black87,
                    splashRadius: getProportionateScreenWidth(18),
                  )
                : TextButton(
                    onPressed: null,
                    child: Text('수락대기'),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.3)))),
      ),
    );
  }
}
