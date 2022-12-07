import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';

class BirthdayInput extends StatefulWidget {
  final SignUpViewModel vm;
  const BirthdayInput({Key? key, required this.vm}) : super(key: key);

  @override
  _BirthdayInputState createState() => _BirthdayInputState();
}

class _BirthdayInputState extends State<BirthdayInput> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '생년월일',
          style: kLabelTextStyle,
        ),
        const VerticalSpacing(of: 10),
        SizedBox(
          height: getProportionateScreenHeight(150),
          child: CupertinoDatePicker(
            minimumYear: 1990,
            maximumYear: DateTime.now().year,
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (dateTime){
              widget.vm.setBirthDay(dateTime);
            }),
        )
       
        
      
      ],
    );
  }
}
