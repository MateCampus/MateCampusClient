import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SearchBar extends StatefulWidget {
  final VoiceCreateViewModel vm;
  const SearchBar({Key? key, required this.vm}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // @override
  // void initState() {
  //   super.initState();
  //   List<String> list = ['단국대학교', '단구기', '단쿠키', '다다미', '노랑나비', '노란색'];
  //   List<String> result = [];
  //   widget.vm.searchFriendController.addListener(() {
  //     setState(() {
  //       result = list.where((element) {
  //         // final listLower = element.toLowerCase();
  //         // final inputLower = widget.vm.searchFriendController.text.toLowerCase();

  //         return element.startsWith(widget.vm.searchFriendController.text);
  //       }).toList();
  //     });
  //   });
  //   print('--------');
  //   print(result);
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(20)),
      child: TextField(
        //autofocus: true,
        keyboardType: TextInputType.multiline,
        style: const TextStyle(fontSize: 14),
        //controller: widget.vm.searchFriendController,
        onChanged: (text) {
          widget.vm.searchRecentUsers(text);
        },
        maxLines: 1,
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xff707070),
            size: 20.0,
          ),
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
