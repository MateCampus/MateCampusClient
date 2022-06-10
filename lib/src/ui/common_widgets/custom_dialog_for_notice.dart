import 'package:flutter/material.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/default_btn.dart';

class CustomDialogForNotice extends StatefulWidget {
  final String description;
  const CustomDialogForNotice({Key? key, required this.description})
      : super(key: key);

  @override
  _CustomDialogForNoticeState createState() => _CustomDialogForNoticeState();
}

class _CustomDialogForNoticeState extends State<CustomDialogForNotice> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(30)),
              child: Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: getProportionateScreenWidth(15)),
              ),
            ),
            DefaultBtn(
              text: '확인',
              height: getProportionateScreenHeight(45),
              press: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
