import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/textstyle_constans.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
import 'package:zamongcampus/src/ui/common_widgets/vertical_spacing.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/components/college_list_tile.dart';
import 'package:zamongcampus/src/ui/views/signup/signup_college/components/major_list_tile.dart';

class SelectMajor extends StatefulWidget {
  final SignUpViewModel vm;
  const SelectMajor({Key? key, required this.vm}) : super(key: key);

  @override
  _SelectMajorState createState() => _SelectMajorState();
}

class _SelectMajorState extends State<SelectMajor> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '학과/학부',
            style: kLabelTextStyle,
          ),
          const VerticalSpacing(of: 15),
          CompositedTransformTarget(
            link: widget.vm.majorLayerLink,
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              style: TextStyle(fontSize: kTextFieldInnerFontSize),
              controller: widget.vm.majorController,
              maxLines: 1,
              onTap: () {
                widget.vm.scrollMajorFieldToTop();
                if (widget.vm.majorOverlayEntry == null) {
                  widget.vm.createMajorOverlay(context, _majorOverlayWidget());
                } else {
                  widget.vm.removeMajorOverlay();
                }
              },
              autocorrect: false,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  CupertinoIcons.arrowtriangle_down_fill,
                  color: Color(0xff767676),
                  size: kTextFieldIconSizeFA,
                ),
                hintText:
                    (widget.vm.isRequested) ? "신청 완료" : "학과 혹은 학부를 선택해주세요",
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
              enabled: (widget.vm.isRequested) ? false : true,
            ),
          ),
          const VerticalSpacing(of: 10),
          _findMajorBtn()
        ],
      ),
    );
  }

  Widget _findMajorBtn() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, "/signUpRequestMajor");
      },
      child: Text(
        '찾는 학교/학과가 없으신가요?',
        style: TextStyle(
            fontSize: kLabelFontSize,
            color: kMainColor,
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  OverlayEntry _majorOverlayWidget() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: SizeConfig.screenWidth! - getProportionateScreenWidth(40),
        child: CompositedTransformFollower(
          link: widget.vm.majorLayerLink,
          offset: Offset(0, getProportionateScreenHeight(57)),
          child: Material(
            child: Container(
              height: getProportionateScreenHeight(250),
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
                itemCount: widget.vm.searchingMajors.length,
                itemBuilder: (context, index) {
                  return MajorListTile(vm: widget.vm, index: index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
