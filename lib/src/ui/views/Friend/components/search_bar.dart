import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/friend_list_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SearchBar extends StatefulWidget {
  final FriendListViewModel vm;
  const SearchBar({Key? key, required this.vm}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    widget.vm.friendSearchController.addListener(() {
      widget.vm.searchFriends();
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
        style: TextStyle(fontSize: kTextFieldInnerFontSize),
        controller: widget.vm.friendSearchController,
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
          hintStyle: TextStyle(
              color: Color(0xFFADADAD), fontSize: kTextFieldInnerFontSize),
          fillColor: kTextFieldColor,
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
