import 'package:flutter/material.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

class CheckOptions extends StatefulWidget {
  const CheckOptions({Key? key}) : super(key: key);

  @override
  State<CheckOptions> createState() => _CheckOptionsState();
}

bool _isSchoolChecked = false;
bool _isMajorChecked = false;

class _CheckOptionsState extends State<CheckOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isSchoolChecked,
          onChanged: (value) {
            setState(() {
              _isSchoolChecked = !_isSchoolChecked;
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
        const Text('같은 학교만 만나기'),
        const HorizontalSpacing(of: 10),
        Checkbox(
          value: _isMajorChecked,
          onChanged: (value) {
            setState(() {
              _isMajorChecked = !_isMajorChecked;
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
        const Text('같은 학과만 만나기'),
      ],
    );
  }
}
