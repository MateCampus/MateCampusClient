import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/components/college_list_tile.dart';

class SelectCollege extends StatefulWidget {
  final SignUpViewModel vm;
  const SelectCollege({Key? key, required this.vm}) : super(key: key);

  @override
  _SelectCollegeState createState() => _SelectCollegeState();
}

class _SelectCollegeState extends State<SelectCollege> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '학교',
            style: TextStyle(
                fontSize: kLabelFontSize,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: CompositedTransformTarget(
              link: widget.vm.collegeLayerLink,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                    fontSize: kTextFieldInnerFontSize, color: Colors.black87),
                controller: widget.vm.collegeController,
                maxLines: 1,
                onTap: () {
                  if (widget.vm.collegeOverlayEntry == null) {
                    widget.vm
                        .createCollegeOverlay(context, _collegeOverlayWidget());
                  } else {
                    widget.vm.removeCollegeOverlay();
                  }
                },
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.school,
                    color: kTextFieldHintColor,
                    size: kTextFieldIconSizeFA,
                  ),
                  hintText: "학교명을 입력해주세요",
                  hintStyle: TextStyle(
                      color: kTextFieldHintColor,
                      fontSize: kTextFieldInnerFontSize),
                  fillColor: kTextFieldColor,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OverlayEntry _collegeOverlayWidget() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: SizeConfig.screenWidth! - getProportionateScreenWidth(40),
        child: CompositedTransformFollower(
          link: widget.vm.collegeLayerLink,
          offset: Offset(0, getProportionateScreenHeight(57)),
          child: Material(
            child: Container(
              height: getProportionateScreenHeight(160),
              decoration: BoxDecoration(
                color: kTextFieldColor,
                border: Border.all(color: kTextFieldHintColor, width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: widget.vm.searchingColleges.length,
                itemBuilder: (context, index) {
                  return CollegeListTile(vm: widget.vm, index: index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
