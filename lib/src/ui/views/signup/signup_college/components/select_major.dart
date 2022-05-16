import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/utils/constants.dart';
import 'package:zamongcampus/src/business_logic/utils/major_data.dart';
import 'package:zamongcampus/src/business_logic/view_models/signup_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

class SelectMajor extends StatefulWidget {
  final SignUpViewModel vm;
  const SelectMajor({Key? key, required this.vm}) : super(key: key);

  @override
  _SelectMajorState createState() => _SelectMajorState();
}

class _SelectMajorState extends State<SelectMajor> {
  //드롭다운 리스트
  final _majorList =
      majorList.map((major) => MajorData.korNameOf(major.name)).toList();

//드롭다운 선택값
  //String _selectedCollege = '학교를 선택해주세요';

  // 드롭박스.
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  final double _dropdownWidth =
      SizeConfig.screenWidth! - getProportionateScreenWidth(40);
  final double _dropdownHeight = getProportionateScreenHeight(48);

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
            child: const Text(
              '학과',
              style: TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
          InkWell(
            onTap: () {
              _createOverlay();
            },
            child: CompositedTransformTarget(
              link: _layerLink,
              child: Container(
                width: _dropdownWidth,
                height: _dropdownHeight,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 선택값.
                    Text(
                      widget.vm.selectedMajor,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 22 / 16,
                        color: Colors.black,
                      ),
                    ),

                    // 아이콘.
                    const Icon(
                      Icons.arrow_downward,
                      size: 16,
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

  OverlayEntry _customDropdown() {
    return OverlayEntry(
      maintainState: true,
      builder: (context) => Positioned(
        width: _dropdownWidth,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, _dropdownHeight + 1),
          child: Material(
            color: Colors.white,
            child: Container(
              height: getProportionateScreenHeight(200),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: ListView.separated(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: _majorList.length,
                itemBuilder: (context, index) {
                  return CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    pressedOpacity: 1,
                    minSize: 0,
                    onPressed: () {
                      //이게 뷰모델이랑 연관.
                      widget.vm.selectMajor(_majorList.elementAt(index));

                      _removeOverlay();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _majorList.elementAt(index),
                        style: const TextStyle(
                          fontSize: 16,
                          height: 22 / 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Divider(
                      color: Colors.grey,
                      height: 20,
                    ),
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
