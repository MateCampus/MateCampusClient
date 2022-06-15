import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
import 'package:zamongcampus/src/config/size_config.dart';

//마찬가지로 관심사 추가 버튼..

class TagCategory extends StatelessWidget {
  final VoiceCreateViewModel vm;
  const TagCategory({Key? key, required this.vm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (vm.selectedCategories.isEmpty)
        ? TextButton(
            onPressed: () {
              vm.setCategory(context);
            },
            child: const Text('관심사 추가 +'),
            style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: const Color(0xffff6f5e),
                shape: const StadiumBorder(),
                minimumSize: const Size(58, 17),
                textStyle: const TextStyle(fontSize: 12)),
          )
        : Wrap(children: [
            TextButton(
              onPressed: () {
                vm.setCategory(context);
              },
              child: const Text('관심사 추가 +'),
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color(0xffff6f5e),
                  shape: const StadiumBorder(),
                  minimumSize: const Size(58, 17),
                  textStyle: const TextStyle(fontSize: 12)),
            ),
            ...vm.selectedCategories
                .map((category) => _selectedCategoryChip(category))
          ]);
  }

  Widget _selectedCategoryChip(CategoryPresentation category) {
    return Stack(alignment: Alignment.topRight, children: [
      Chip(
        label: Text(category.title),
        labelStyle: TextStyle(
          fontSize: getProportionateScreenWidth(12),
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xffe2e2e2), width: 1.2),
      ),
      Container(
          // 이거 x 아이콘으로 바꾸고 위치 위로 올리고 Inkwell씌워서 ontap하면 리스트 삭제하게끔.
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            Icons.check_circle,
            color: const Color(0xffe2e2e2),
            size: getProportionateScreenHeight(16),
          ))
    ]);
  }
}
