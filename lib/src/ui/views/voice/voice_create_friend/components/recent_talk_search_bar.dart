import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class RecentTalkSearchBar extends StatefulWidget {
  final VoiceCreateViewModel vm;
  const RecentTalkSearchBar({Key? key, required this.vm}) : super(key: key);

  @override
  State<RecentTalkSearchBar> createState() => _RecentTalkSearchBarState();
}

class _RecentTalkSearchBarState extends State<RecentTalkSearchBar> {
  @override
  void initState() {
    widget.vm.recentTalkSearchController.addListener(() {
      widget.vm.searchRecentTalkUsers();
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
        style: const TextStyle(fontSize: 14),
        controller: widget.vm.recentTalkSearchController,
        // onChanged: (text) {
        //   widget.vm.searchRecentTalkUsers(text);
        // },
        maxLines: 1,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xff707070),
            size: getProportionateScreenHeight(20),
          ),
          suffixIcon: widget.vm.recentTalkSearchController.text.isNotEmpty
              ? _clearTextFieldBtn()
              : const SizedBox(),
          contentPadding: EdgeInsets.zero,
          hintText: "친구 검색",
          hintStyle: const TextStyle(color: Color(0xFFADADAD), fontSize: 14),
          fillColor: const Color(0xfff8f8f8),
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
        widget.vm.clearSearchTextField(widget.vm.recentTalkSearchController);
      },
      child: Icon(
        Icons.close,
        color: const Color(0xff707070),
        size: getProportionateScreenHeight(15),
      ),
    );
  }
}
