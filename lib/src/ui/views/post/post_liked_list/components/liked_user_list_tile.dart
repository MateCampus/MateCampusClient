

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/post_liked_list_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';

class LikedUserListTile extends StatelessWidget {
  final PostLikedListViewModel vm;
  final PostLikedUserPresentation likeduser;
  const LikedUserListTile({ Key? key, required this.vm, required this.likeduser }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            //아마 프로필 보이는걸로 해야하지 않을까
          },
          child: ListTile(
            dense: true,
            visualDensity: const VisualDensity(horizontal: -2),
            leading: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: getProportionateScreenHeight(18),
            backgroundImage: likeduser.profileImageUrl.startsWith('https')
                ? CachedNetworkImageProvider(likeduser.profileImageUrl) as ImageProvider
                : AssetImage(likeduser.profileImageUrl),
          ),
          title: Text(
            likeduser.nickname,
            style: TextStyle(
                fontSize: resizeFont(12),
                color: Color(0xff111111),
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            likeduser.collegeName,
            style: TextStyle(
                fontSize: resizeFont(12),
                color: Color(0xff767676),
                fontWeight: FontWeight.w300),
          ),
          ),
        
        ),
        const HorizontalDividerCustom(
          color: Color(0xfff0f0f6),
        )
      ],
    );
  }
}