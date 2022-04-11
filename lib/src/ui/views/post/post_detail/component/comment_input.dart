import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({Key? key}) : super(key: key);

  @override
  _CommentInputState createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, getProportionateScreenHeight(10), 0,
          getProportionateScreenHeight(25)),
      child: Container(
        width: getProportionateScreenHeight(335),
        height: getProportionateScreenHeight(50),
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(10),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xfff8f8f8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: getProportionateScreenWidth(275),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '소중한 댓글을 남겨주세요',
                    hintStyle:
                        TextStyle(color: Color(0xFFADADAD), fontSize: 14),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    isDense: true,
                  ),
                  cursorColor: mainColor,
                )),
            TextButton(
              onPressed: () {},
              child: const Text('전송'),
              style: TextButton.styleFrom(
                  minimumSize: Size(getProportionateScreenWidth(44),
                      getProportionateScreenHeight(36)),
                  backgroundColor: mainColor,
                  primary: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
