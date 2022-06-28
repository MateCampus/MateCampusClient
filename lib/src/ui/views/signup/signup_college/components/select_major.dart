import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/size_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';
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
            style: TextStyle(
                fontSize: kLabelFontSize,
                color: Colors.black54,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: CompositedTransformTarget(
              link: widget.vm.majorLayerLink,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                style: TextStyle(
                    fontSize: kTextFieldInnerFontSize, color: Colors.black87),
                controller: widget.vm.majorController,
                maxLines: 1,
                onTap: () {
                  widget.vm.scrollMajorFieldToTop();
                  if (widget.vm.majorOverlayEntry == null) {
                    widget.vm
                        .createMajorOverlay(context, _majorOverlayWidget());
                  } else {
                    widget.vm.removeMajorOverlay();
                  }
                },
                autocorrect: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    FontAwesomeIcons.school,
                    color: kTextFieldHintColor,
                    size: kTextFieldIconSizeFA,
                  ),
                  hintText:
                      (widget.vm.isRequested) ? "신청 완료" : "학과 혹은 학부명을 입력해주세요",
                  hintStyle: TextStyle(
                      color: kTextFieldHintColor,
                      fontSize: kTextFieldInnerFontSize),
                  fillColor: kTextFieldColor,
                  filled: true,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                enabled: (widget.vm.isRequested) ? false : true,
              ),
            ),
          ),
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
              height: getProportionateScreenHeight(260),
              decoration: BoxDecoration(
                color: kTextFieldColor,
                border: Border.all(color: kTextFieldHintColor, width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.builder(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.zero,
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
