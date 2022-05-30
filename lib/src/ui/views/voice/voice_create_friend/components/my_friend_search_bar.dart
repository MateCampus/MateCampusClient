import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class MyFriendSearchBar extends StatefulWidget {
  final VoiceCreateViewModel vm;
  const MyFriendSearchBar({Key? key, required this.vm}) : super(key: key);

  @override
  State<MyFriendSearchBar> createState() => _MyFriendSearchBarState();
}

class _MyFriendSearchBarState extends State<MyFriendSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(15)),
      child: TextField(
        keyboardType: TextInputType.multiline,
        style: const TextStyle(fontSize: 14),
        //controller: widget.vm.friendSearchController,
        onChanged: (text) {
          widget.vm.searchFriendUsers(text);
        },
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xff707070),
            size: getProportionateScreenHeight(20),
          ),
          // suffixIcon: Icon(
          //   Icons.close,
          //   color: Color(0xff707070),
          //   size: getProportionateScreenHeight(20),
          // ),
          contentPadding: EdgeInsets.zero,
          hintText: "친구 검색",
          hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 14),
          fillColor: Color(0xfff8f8f8),
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }
}
