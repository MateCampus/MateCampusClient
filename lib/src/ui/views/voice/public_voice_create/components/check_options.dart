// import 'package:flutter/material.dart';
// import 'package:zamongcampus/src/business_logic/constants/color_constants.dart';
// import 'package:zamongcampus/src/business_logic/view_models/voice_create_viewmodel.dart';
// import 'package:zamongcampus/src/ui/common_widgets/horizontal_spacing.dart';

// class CheckOptions extends StatefulWidget {
//   final VoiceCreateViewModel vm;
//   const CheckOptions({Key? key, required this.vm}) : super(key: key);

//   @override
//   State<CheckOptions> createState() => _CheckOptionsState();
// }

// class _CheckOptionsState extends State<CheckOptions> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Checkbox(
//           value: widget.vm.collegeOnlyChecked,
//           onChanged: (value) {
//             widget.vm.setCollegeOption(value!);
//           },
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//           activeColor: kMainColor,
//           side: const BorderSide(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         ),
//         const Text('같은 학교만 만나기'),
//         const HorizontalSpacing(of: 10),
//         Checkbox(
//           value: widget.vm.majorOnlyChecked,
//           onChanged: (value) {
//             widget.vm.setMajorOption(value!);
//           },
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
//           activeColor: kMainColor,
//           side: const BorderSide(
//             color: Colors.grey,
//             width: 1.0,
//           ),
//           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//         ),
//         const Text('같은 학과만 만나기'),
//       ],
//     );
//   }
// }
