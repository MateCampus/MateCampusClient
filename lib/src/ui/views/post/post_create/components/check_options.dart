import 'package:flutter/material.dart';

class CheckOptions extends StatefulWidget {
  const CheckOptions({Key? key}) : super(key: key);

  @override
  _CheckOptionsState createState() => _CheckOptionsState();
}

bool _isChecked = false;

class _CheckOptionsState extends State<CheckOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (value) {
            setState(() {
              _isChecked = !_isChecked;
            });
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          activeColor: const Color(0xffff6f5e),
          side: const BorderSide(
            color: Colors.grey,
            width: 1.5,
          ),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        const Text('같은 학교만 보여주기')
      ],
    );
  }
}
