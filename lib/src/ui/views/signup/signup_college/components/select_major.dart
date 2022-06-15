import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
import 'package:zamongcampus/src/business_logic/constants/font_constants.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';
import 'package:zamongcampus/src/ui/common_widgets/horizontalDividerCustom.dart';

class SelectMajor extends StatefulWidget {
  final SignUpViewModel vm;
  const SelectMajor({Key? key, required this.vm}) : super(key: key);

  @override
  _SelectMajorState createState() => _SelectMajorState();
}

class _SelectMajorState extends State<SelectMajor> {
  //드롭다운 리스트
  final _majorList = majorList;

  // 드롭박스.
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final double _dropdownWidth =
      SizeConfig.screenWidth! - getProportionateScreenWidth(40);
  final double _dropdownHeight = getProportionateScreenHeight(48);

  @override
  void dispose() {
    _overlayEntry?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: getProportionateScreenHeight(10)),
            child: Text(
              '내 학과',
              style: TextStyle(fontSize: kLabelFontSize, color: Colors.black87),
            ),
          ),
          InkWell(
            onTap: () {
              if (_overlayEntry == null) {
                _createOverlay();
              } else {
                _removeOverlay();
              }
            },
            child: CompositedTransformTarget(
              link: _layerLink,
              child: Container(
                width: _dropdownWidth,
                height: _dropdownHeight,
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                decoration: BoxDecoration(
                  color: kTextFieldColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 선택값.
                    (widget.vm.selectedMajor == '')
                        ? const Text(
                            '학과를 선택해주세요',
                            style: TextStyle(
                                color: Color(0xFFADADAD), fontSize: 14),
                          )
                        : Text(
                            widget.vm.selectedMajor,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                    const Icon(
                      Icons.arrow_drop_down,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

// 드롭다운 생성.
  void _createOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _customDropdown();
      Overlay.of(context)?.insert(_overlayEntry!);
    }
  }

  // 드롭다운 해제.
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  //드롭다운 모양
  OverlayEntry _customDropdown() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: _dropdownWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, _dropdownHeight + getProportionateScreenHeight(5)),
          child: Material(
            child: Container(
              height: getProportionateScreenHeight(200),
              decoration: BoxDecoration(
                color: kTextFieldColor,
                //border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    vertical: getProportionateScreenHeight(0)),
                itemCount: _majorList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      widget.vm.selectMajor(_majorList.elementAt(index));
                      _removeOverlay();
                    },
                    child: Container(
                      height: _dropdownHeight,
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          MajorData.korNameOf(_majorList.elementAt(index).name),
                          //_collegeList.elementAt(index),
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const HorizontalDividerCustom(
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
