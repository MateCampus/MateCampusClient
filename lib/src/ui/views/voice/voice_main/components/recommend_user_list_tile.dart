import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_main_screen_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class RecommendUserListTile extends StatelessWidget {
  UserPresentation recommendUser;
  RecommendUserListTile({Key? key, required this.recommendUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getProportionateScreenWidth(116),
      height: getProportionateScreenHeight(133),
      margin: EdgeInsets.only(right: getProportionateScreenWidth(5)),
      child: Card(
        shape: RoundedRectangleBorder(
          //모서리를 둥글게 하기 위해 사용
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(recommendUser.imageUrls.first),
                  ),
                  Positioned(
                    bottom: 1,
                    right: -1,
                    child: Container(
                        width: getProportionateScreenWidth(15),
                        height: getProportionateScreenHeight(15),
                        decoration: BoxDecoration(
                          color: recommendUser.isOnline
                              ? const Color(0xff00FFBA) //온라인 상태일 때 색
                              : Colors.grey, //오프라인 상태일 떄 색
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Colors.white,
                              width: 3.0,
                              style: BorderStyle.solid),
                        )),
                  )
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "#" + recommendUser.majorName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "#" + recommendUser.collegeName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
