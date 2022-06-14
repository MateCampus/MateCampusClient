import 'package:flutter/cupertino.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class CustomDialogForNotice extends StatelessWidget {
  final String description;
  const CustomDialogForNotice({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Text(
        description,
        style: TextStyle(fontSize: getProportionateScreenWidth(14)),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('확인'),
          textStyle: TextStyle(
            fontSize: getProportionateScreenWidth(12),
          ),
        )
      ],
    );
  }
}
