import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zamongcampus/src/config/size_config.dart';

// 이 부분이 나중에 shimmer로 바뀌어야함
class IsLoading extends StatelessWidget {
  const IsLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      color: Colors.grey,
      size: getProportionateScreenHeight(25),
    );
  }
}
