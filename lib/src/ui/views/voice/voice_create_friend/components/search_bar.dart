import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      //autofocus: true,
      keyboardType: TextInputType.multiline,
      style: TextStyle(fontSize: 14),
      //controller: widget.textInput,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xff707070),
          size: 20.0,
        ),
        hintText: "친구 검색",
        hintStyle: TextStyle(color: Color(0xFFADADAD), fontSize: 14),
        fillColor: Color(0xfff8f8f8),
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }
}
