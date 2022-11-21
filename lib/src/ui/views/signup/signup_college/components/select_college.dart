import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
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
            style: kLabelTextStyle,
          ),
          const VerticalSpacing(of: 15),
          CompositedTransformTarget(
            link: widget.vm.collegeLayerLink,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              style: TextStyle(fontSize: kTextFieldInnerFontSize),
              controller: widget.vm.collegeController,
              maxLines: 1,
              onTap: () {
                widget.vm.scrollCollegeFieldToTop();
                if (widget.vm.collegeOverlayEntry == null) {
                  widget.vm
                      .createCollegeOverlay(context, _collegeOverlayWidget());
                } else {
                  widget.vm.removeCollegeOverlay();
                }
              },
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  CupertinoIcons.arrowtriangle_down_fill,
                  color: Color(0xff767676),
                  size: kTextFieldIconSizeFA,
                ),
                hintText: "학교를 선택해주세요",
                hintStyle: TextStyle(
                    color: const Color(0xFF999999),
                    fontSize: kTextFieldInnerFontSize),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffe5e5ec)),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffe5e5ec)),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Color(0xffe5e5ec)),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
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
              height: getProportionateScreenHeight(220),
              decoration: BoxDecoration(
                // color: kTextFieldColor,
                border: Border.all(color: Color(0xffe5e5ec), width: 1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                separatorBuilder: (BuildContext context, int index) =>
                    const HorizontalDividerCustom(color: Color(0xfff0f0f6)),
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(5)),
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
