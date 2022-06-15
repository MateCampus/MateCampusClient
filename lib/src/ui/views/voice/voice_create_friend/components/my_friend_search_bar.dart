import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class MyFriendSearchBar extends StatefulWidget {
  final dynamic vm;
  const MyFriendSearchBar({Key? key, required this.vm}) : super(key: key);

  @override
  State<MyFriendSearchBar> createState() => _MyFriendSearchBarState();
}

class _MyFriendSearchBarState extends State<MyFriendSearchBar> {
  @override
  void initState() {
    widget.vm.friendSearchController.addListener(() {
      widget.vm.searchFriendUsers();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(15)),
      child: TextField(
        keyboardType: TextInputType.multiline,
        style: TextStyle(fontSize: kTextFieldInner),
        controller: widget.vm.friendSearchController,
        // onChanged: (text) {
        //   widget.vm.searchFriendUsers(text);
        // },
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xff707070),
            size: getProportionateScreenHeight(20),
          ),
          suffixIcon: widget.vm.friendSearchController.text.isNotEmpty
              ? _clearTextFieldBtn()
              : const SizedBox(),
          contentPadding: EdgeInsets.zero,
          hintText: "친구 검색",
          hintStyle:
              TextStyle(color: Color(0xFFADADAD), fontSize: kTextFieldInner),
          fillColor: screenBackgroundColor,
          filled: true,
          border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
  }

  Widget _clearTextFieldBtn() {
    return InkWell(
      onTap: () {
        widget.vm.clearSearchTextField(widget.vm.friendSearchController);
      },
      child: Icon(
        Icons.close,
        color: const Color(0xff707070),
        size: getProportionateScreenHeight(15),
      ),
    );
  }
}
